require "json"
require "./account"
require "./status"

module Mastodon
  module Entities
    class Results
      include JSON::Serializable

      @[JSON::Field(key: "accounts")]
      property accounts : Array(Entities::Account?)

      @[JSON::Field(key: "statuses")]
      property statuses : Array(Entities::Status?)

      @[JSON::Field(key: "hashtags")]
      property hashtags : Array(String?)
    end
  end
end
