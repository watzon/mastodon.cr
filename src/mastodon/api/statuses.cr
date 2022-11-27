module Mastodon
  module API
    module Statuses
      private STATUSES_BASE = "/api/v1/statuses"

      def status(id)
        # Does not require authentication
        response = get("#{STATUSES_BASE}/#{id}")
        Entities.from_response(response, Entities::Status)
      end

      def create_status(
        status,
        media_ids = [] of Int32,
        poll_options = [] of String,
        poll_expires_in = nil,
        poll_multiple = false,
        poll_hide_totals = false,
        in_reply_to_id = nil,
        sensitive = false,
        spoiler_text = "",
        visibility = "",
        scheduled_at = nil,
        language = nil
      )
        forms = HTTP::Params.build do |form|
          form.add "status", "#{status}"
          media_ids.map { |id| form.add "media_ids[]", "#{id}" }
          poll_options.map { |option| form.add "poll[options][]", "#{option}" }
          form.add "poll[expires_in]", "#{poll_expires_in}" if poll_expires_in
          form.add "poll[multiple]", "" if poll_multiple
          form.add "poll[hide_totals]", "" if poll_hide_totals
          form.add "in_reply_to_id", "#{in_reply_to_id}" if in_reply_to_id
          form.add "sensitive", "true" if sensitive
          form.add "spoiler_text", "#{spoiler_text}" unless spoiler_text.empty?
          form.add "visibility", "#{visibility}" if ["direct", "private", "unlisted", "public"].includes?(visibility)
          form.add "scheduled_at", "#{scheduled_at}" if scheduled_at
          form.add "language", "#{language}" if language
        end
        response = post("#{STATUSES_BASE}", forms)
        Entities.from_response(response, Entities::Status)
      end

      def delete_status(id)
        delete("#{STATUSES_BASE}/#{id}")
        nil
      end

      def context(id)
        # Does not require authentication
        response = get("#{STATUSES_BASE}/#{id}/context")
        Entities.from_response(response, Entities::Context)
      end

      def card(id)
        # Does not require authentication
        response = get("#{STATUSES_BASE}/#{id}/card")
        Entities.from_response(response, Entities::Card)
      end

      {% for method in {"reblogged_by", "favourited_by"} %}
      def {{ method.id }}(id, max_id = nil, since_id = nil, limit = DEFAULT_ACCOUNTS_LIMIT)
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= DEFAULT_ACCOUNTS_LIMIT * 2
        end
        response = get("#{STATUSES_BASE}/#{id}/{{ method.id }}", params)
        Entities.from_response(response, Collection(Entities::Account))
      end
      {% end %}

      {% for method in {"reblog", "unreblog", "favourite", "unfavourite", "bookmark", "unbookmark", "mute", "unmute", "pin", "unpin"} %}
      def {{ method.id }}_status(id)
        response = post("#{STATUSES_BASE}/#{id}/{{ method.id }}")
        Entities.from_response(response, Entities::Status)
      end
      {% end %}
    end
  end
end
