require "json"

module Mastodon
  module Entities
    class Mention
      include JSON::Serializable

      @[JSON::Field(key: "url")]
      property url : String

      @[JSON::Field(key: "username")]
      property username : String

      @[JSON::Field(key: "acct")]
      property acct : String

      @[JSON::Field(key: "id")]
      property id : String
    end
  end
end
