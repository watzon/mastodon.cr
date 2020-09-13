require "json"

module Mastodon
  module Entities
    class Tag
      include JSON::Serializable

      @[JSON::Field(key: "name")]
      property name : String

      @[JSON::Field(key: "url")]
      property url : String
    end
  end
end
