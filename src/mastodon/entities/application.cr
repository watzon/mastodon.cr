require "json"

module Mastodon
  module Entities
    class Application
      include JSON::Serializable

      @[JSON::Field(key: "name")]
      property name : String

      @[JSON::Field(key: "website")]
      property website : String?
    end
  end
end
