require "json"
require "./account"
require "./status"

module Mastodon
  module Entities
    class Notification
      include JSON::Serializable

      @[JSON::Field(key: "id")]
      property id : String

      @[JSON::Field(key: "type")]
      property type : String # "mention", "reblog", "favourite", "follow"

      @[JSON::Field(key: "created_at", converter: Time::Format.new("%Y-%m-%dT%T"))]
      property created_at : Time

      @[JSON::Field(key: "account")]
      property account : Entities::Account

      @[JSON::Field(key: "redirect_uri")]
      property status : Entities::Status?
    end
  end
end
