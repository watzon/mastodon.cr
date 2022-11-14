module Mastodon
  module Entities
    # TODO: Fix once documentation is available
    class Report
      include JSON::Serializable

      property id : String

      property action_taken : Bool

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property action_taken_at : Time?

      property category : String?

      property comment : String?

      property forwarded : Bool?

      property created_at : Time?

      property status_ids : Array(String) = [] of String

      property rule_ids : Array(String) = [] of String

      def_equals id
    end
  end
end
