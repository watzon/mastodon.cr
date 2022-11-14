module Mastodon
  module Entities
    class Notification
      include JSON::Serializable

      property id : String

      # TODO: Make enum
      property type : String # "follow", "follow_request", "mention", "reblog", "favourite", "poll", "status"

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property created_at : Time

      property account : Account

      property status : Status?
    end
  end
end
