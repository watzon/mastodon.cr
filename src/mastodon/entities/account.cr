require "json"

module Mastodon
  module Entities
    class Account
      include JSON::Serializable

      @[JSON::Field(key: "id")]
      property id : String

      @[JSON::Field(key: "username")]
      property username : String

      @[JSON::Field(key: "acct")]
      property acct : String

      @[JSON::Field(key: "display_name")]
      property display_name : String

      @[JSON::Field(key: "locked")]
      property locked : Bool

      @[JSON::Field(key: "created_at", converter: Time::Format.new("%Y-%m-%dT%T"))]
      property created_at : Time

      @[JSON::Field(key: "followers_count")]
      property followers_count : Int32

      @[JSON::Field(key: "following_count")]
      property following_count : Int32

      @[JSON::Field(key: "statuses_count")]
      property statuses_count : Int32

      @[JSON::Field(key: "note")]
      property note : String

      @[JSON::Field(key: "url")]
      property url : String

      @[JSON::Field(key: "avatar")]
      property avatar : String

      @[JSON::Field(key: "avatar_static")]
      property avatar_static : String

      @[JSON::Field(key: "header")]
      property header : String

      @[JSON::Field(key: "header_static")]
      property header_static : String

      def_equals id
    end
  end
end
