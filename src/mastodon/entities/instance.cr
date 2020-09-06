require "json"

module Mastodon
  module Entities
    class Instance
      include JSON::Serializable

      @[JSON::Field(key: "uri")]
      property uri : String

      @[JSON::Field(key: "title")]
      property title : String

      @[JSON::Field(key: "description")]
      property description : String

      @[JSON::Field(key: "email")]
      property email : String

      @[JSON::Field(key: "version")]
      property version : String
    end
  end
end
