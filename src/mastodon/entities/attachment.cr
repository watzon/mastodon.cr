module Mastodon
  module Entities
    class Attachment
      include JSON::Serializable

      property id : String

      # TODO: Make enum
      property type : String # "image", "video", "gifv"

      property url : String

      property preview_url : String

      property remote_url : String?

      property meta : Hash(String, Attachment::Metadata)?

      property description : String?

      property blurhash : String?

      def_equals id

      class Metadata
        include JSON::Serializable

        property length : String?

        property duration : Float64?

        property fps : Int32?

        property size : String?

        property width : Int32?

        property height : Int32?

        property aspect : Float64?

        property audio_encode : String?

        property audio_bitrate : String?

        property audio_channels : String?

        property original : Original?

        property small : Small?

        class Original
          include JSON::Serializable

          property width : Int32

          property height : Int32

          property frame_rate : String

          property duration : Float64

          property bitrate : Int32
        end

        class Small
          include JSON::Serializable

          property width : Int32

          property height : Int32

          property size : String

          property aspect : Float64
        end
      end
    end
  end
end
