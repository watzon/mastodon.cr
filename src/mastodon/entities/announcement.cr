module Mastodon
  module Entities
    class Announcement
      include JSON::Serializable

      property id : String

      property content : String

      property all_day : Bool

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property published_at : Time

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property updated_at : Time

      property read : Bool

      property mentions : Array(Mention)

      property statuses : Array(Status)

      property tags : Array(Tag)

      property emojis : Array(Emoji)

      property reactions : Array(AnnouncementReaction)

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property scheduled_at : Time?

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property starts_at : Time?

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property ends_at : Time?
    end
  end
end
