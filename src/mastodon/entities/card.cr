require "json"

module Mastodon
  module Entities
    class Card
      include JSON::Serializable

      @[JSON::Field(key: "url")]
      property url : String?

      @[JSON::Field(key: "title")]
      property title : String?

      @[JSON::Field(key: "description")]
      property description : String?

      @[JSON::Field(key: "image")]
      property image : String?
    end
  end
end
