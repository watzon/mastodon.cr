require "../client"

module Mastodon
  module API
    module Streaming
      private STREAMING_BASE = "/api/v1/streaming"

      @streaming_callbacks = {
        update:                [] of Proc(Entities::Status, Nil),
        notification:          [] of Proc(Entities::Notification, Nil),
        delete:                [] of Proc(Int32, Nil),
        filters_changed:       [] of Proc(Nil),
        conversation:          [] of Proc(Entities::Conversation, Nil),
        announcement:          [] of Proc(Entities::Announcement, Nil),
        announcement_reaction: [] of Proc(NamedTuple(name: String, count: Int32, announcement_id: String), Nil),
        announcement_delete:   [] of Proc(String, Nil),
        status_update:         [] of Proc(Entities::Status, Nil),
      }

      def on_update(&block : Entities::Status ->)
        @streaming_callbacks[:update] << block
      end

      def on_delete(&block : Int32 ->)
        @streaming_callbacks[:delete] << block
      end

      def on_notification(&block : Entities::Notification ->)
        @streaming_callbacks[:notification] << block
      end

      def on_filters_changed(&block)
        @streaming_callbacks[:filters_changed] << block
      end

      def on_conversation(&block : Entities::Conversation ->)
        @streaming_callbacks[:conversation] << block
      end

      def on_announcement(&block : Entities::Announcement ->)
        @streaming_callbacks[:announcement] << block
      end

      def on_announcement_reaction(&block : NamedTuple(name: String, count: Int32, announcement_id: String) ->)
        @streaming_callbacks[:announcement_reaction] << block
      end

      def on_announcement_delete(&block : String ->)
        @streaming_callbacks[:announcement_delete] << block
      end

      def on_status_update(&block : Entities::Status ->)
        @streaming_callbacks[:status_update] << block
      end

      def user_stream(&block : Entities::Status | Entities::Notification | Int32 ->)
        stream("#{STREAMING_BASE}/user") do |object|
          yield object
        end
      end

      def notification_stream(&block : Entities::Notification ->)
        stream("#{STREAMING_BASE}/notifications") do |object|
          yield object
        end
      end

      def public_stream(&block : Entities::Status | Int32 ->)
        stream("#{STREAMING_BASE}/public") do |object|
          yield object if object.is_a?(Entities::Status | Int32)
        end
      end

      def local_stream(&block : Entities::Status | Int32 ->)
        stream("#{STREAMING_BASE}/public/local") do |object|
          yield object if object.is_a?(Entities::Status | Int32)
        end
      end

      def remote_stream(&block : Entities::Status | Int32 ->)
        stream("#{STREAMING_BASE}/public/remote") do |object|
          yield object if object.is_a?(Entities::Status | Int32)
        end
      end

      def hashtag_stream(hashtag, local = false, &block : Entities::Status | Int32 ->)
        path = local ? "#{STREAMING_BASE}/hashtag/local/#{hashtag}" : "#{STREAMING_BASE}/hashtag/#{hashtag}"
        stream(path) do |object|
          yield object if object.is_a?(Entities::Status | Int32)
        end
      end

      def list_stream(list_id, &block : Entities::Status | Int32 ->)
        stream("#{STREAMING_BASE}/list/#{list_id}") do |object|
          yield object if object.is_a?(Entities::Status | Int32)
        end
      end

      def direct_stream(&block : Entities::Status | Int32 ->)
        stream("#{STREAMING_BASE}/direct") do |object|
          yield object if object.is_a?(Entities::Status | Int32)
        end
      end

      def user_stream
        stream("#{STREAMING_BASE}/user")
      end

      def notification_stream
        stream("#{STREAMING_BASE}/notifications")
      end

      def public_stream
        stream("#{STREAMING_BASE}/public")
      end

      def local_stream
        stream("#{STREAMING_BASE}/public/local")
      end

      def remote_stream
        stream("#{STREAMING_BASE}/public/remote")
      end

      def hashtag_stream(hashtag, local = false)
        path = local ? "#{STREAMING_BASE}/hashtag/local/#{hashtag}" : "#{STREAMING_BASE}/hashtag/#{hashtag}"
        stream(path)
      end

      def list_stream(list_id)
        stream("#{STREAMING_BASE}/list/#{list_id}")
      end

      def direct_stream
        stream("#{STREAMING_BASE}/direct")
      end

      private def stream(path, &block)
        proccess_streaming(path) do |event, data|
          case event
          when "update"
            yield event, Entities::Status.from_json(data)
          when "delete"
            yield event, data.to_i
          when "notification"
            yield event, Entities::Notification.from_json(data)
          when "filters_changed"
            yield event
          when "conversation"
            yield event, Entities::Conversation.from_json(data)
          when "announcement"
            yield event, Entities::Announcement.from_json(data)
          when "announcement.reaction"
            yield event, NamedTuple(name: String, count: Int32, announcement_id: String).from_json(data)
          when "announcement.delete"
            yield event, data
          when "status.update"
            yield event, Entities::Status.from_json(data)
          when "encrypted_message"
            yield event
          end
        end
      end

      private def stream(path)
        stream do |event, entity|
          case event
          when "update"
            ent = entity.as(Entities::Status)
            @streaming_callbacks[:update].each(&.call(ent))
          when "delete"
            @streaming_callbacks[:delete].each(&.call(data.to_i))
          when "notification"
            ent = entity.as(Entities::Notification)
            @streaming_callbacks[:notification].each(&.call(ent))
          when "filters_changed"
            @streaming_callbacks[:filters_changed].each(&.call)
          when "conversation"
            ent = entity.as(Entities::Conversation)
            @streaming_callbacks[:conversation].each(&.call(ent))
          when "announcement"
            ent = entity.as(Entities::Announcement)
            @streaming_callbacks[:announcement].each(&.call(ent))
          when "announcement.reaction"
            ent = entity.as(NamedTuple(name: String, count: Int32, announcement_id: String))
            @streaming_callbacks[:announcement_reaction].each(&.call(ent))
          when "announcement.delete"
            @streaming_callbacks[:announcement_delete].each(&.call(data))
          when "status.update"
            ent = entity.as(Entities::Status)
            @streaming_callbacks[:status_update].each(&.call(ent))
          when "encrypted_message"
            # not implemented yet
          end
        end
      end

      private def proccess_streaming(path : String)
        @http_client.get(path, default_headers) do |response|
          case response.status_code
          when 200
            begin
              while line = response.body_io.read_line
                next if line.starts_with?(':')
                if line && line =~ /^event: /
                  data_line = response.body_io.read_line
                  if data_line && data_line =~ /^data: /
                    event = line["event: ".size..-1]
                    data = data_line["data: ".size..-1]
                    yield event, data
                  end
                end
              end
            rescue ex # IO::EOFError
              break
            end
          else
            raise Streaming::Error.new(response)
          end
        end
      end
    end
  end
end
