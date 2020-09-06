require "json"

module Mastodon
  module Entities
    class Relationship
      include JSON::Serializable

      @[JSON::Field(key: "id")]
      property id : String

      @[JSON::Field(key: "following")]
      property following : Bool

      @[JSON::Field(key: "blocking")]
      property blocking : Bool

      @[JSON::Field(key: "muting")]
      property muting : Bool

      # @[JSON::Field(key: "muting_boosts")]
      # property muting_boosts : Bool

      @[JSON::Field(key: "requested")]
      property requested : Bool

      @[JSON::Field(key: "domain_blocking")]
      property domain_blocking : Bool
    end
  end
end
