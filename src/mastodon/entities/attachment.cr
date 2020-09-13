require "json"

module Mastodon
  module Entities
    class Attachment
      include JSON::Serializable

      @[JSON::Field(key: "id")]
      property id : String

      @[JSON::Field(key: "type")]
      property type : String # "image", "video", "gifv"

      @[JSON::Field(key: "url")]
      property url : String

      @[JSON::Field(key: "remote_url")]
      property remote_url : String?

      @[JSON::Field(key: "preview_url")]
      property preview_url : String

      @[JSON::Field(key: "text_url")]
      property text_url : String?

      # @[JSON::Field(key: "meta")]
      # property meta : Hash(String, Attachment::MetaData)?

      def_equals id

      class MetaData
        include JSON::Serializable

        @[JSON::Field(key: "width")]
        property width : Int32

        @[JSON::Field(key: "height")]
        property height : Int32

        @[JSON::Field(key: "size")]
        property size : String

        @[JSON::Field(key: "aspect")]
        property aspect : Float32
      end
    end
  end
end
