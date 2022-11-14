module Mastodon
  module Entities
    class FeaturedTag
      include JSON::Serializable

      property id : String

      property name : String

      property url : String

      property statuses_count : Int32

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property last_status_at : Time
    end
  end
end
