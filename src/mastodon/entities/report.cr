require "json"

module Mastodon
  module Entities
    class Report
      include JSON::Serializable

      @[JSON::Field(key: "id")]
      property id : String

      @[JSON::Field(key: "action_taken")]
      property action_taken : Bool

      def_equals id
    end
  end
end
