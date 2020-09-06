require "json"
require "./status"

module Mastodon
  module Entities
    class Context
      include JSON::Serializable

      @[JSON::Field(key: "ancestors")]
      property ancestors : Array(Entities::Status)

      @[JSON::Field(key: "descendants")]
      property descendants : Array(Entities::Status)
    end
  end
end
