module Mastodon
  module Entities
    # TODO: Fix once documentation is available
    class ScheduledStatus
      include JSON::Serializable

      property id : String

      property scheduled_at : String

      property params : Params

      property media_attachments : Array(Attachment)

      class Params
        include JSON::Serializable

        property text : String

        property media_ids : Array(String) = [] of String

        property sensitive : Bool = false

        property spoiler_text : String?

        # TODO: Make enum
        property visibility : String # public, unlisted, private, direct

        @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
        property scheduled_at : Time

        # property poll : Bool = false

        # property idempotency : Nil

        property in_reply_to_id : String?

        property application_id : Int32
      end
    end
  end
end
