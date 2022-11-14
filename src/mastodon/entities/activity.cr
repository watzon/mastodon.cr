module Mastodon
  module Entities
    class Activity
      include JSON::Serializable

      @[JSON::Field(converter: Time::EpochConverter)]
      property week : String

      property statuses : String

      property logins : String

      property registrations : String
    end
  end
end
