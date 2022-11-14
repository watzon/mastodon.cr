module Mastodon
  module Entities
    class Poll
      include JSON::Serializable

      property id : String

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property expires_at : Time

      property expired : Bool

      property multiple : Bool

      property votes_count : Int32

      property voters_count : Int32

      property voted : Bool

      property own_votes : Array(Int32)

      property options : Array(Option)

      property emojis : Array(Emoji)

      class Option
        include JSON::Serializable

        property title : String

        property votes_count : Int32
      end
    end
  end
end
