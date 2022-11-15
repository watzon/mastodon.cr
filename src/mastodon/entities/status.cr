module Mastodon
  module Entities
    class Status
      include JSON::Serializable

      property id : String

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property created_at : Time

      property in_reply_to_id : String?

      property in_reply_to_account_id : String?

      property sensitive : Bool

      property spoiler_text : String

      # TODO: Make enum
      property visibility : String # public, unlisted, private, direct

      property language : String?

      property uri : String

      property url : String?

      property replies_count : Int32

      property reblogs_count : Int32

      property favourites_count : Int32

      property content : String

      property reblog : Bool?

      # nilable, even though the docs say otherwise
      property application : Application?

      property account : Account

      property media_attachments : Array(Attachment)

      property mentions : Array(Mention)

      property tags : Array(Tag)

      property emojis : Array(Emoji)

      property card : Card?

      property poll : Poll?

      property text : String?

      # Authorized users
      property favourited : Bool?

      property reblogged : Bool?

      property muted : Bool?

      property bookmarked : Bool?

      property pinned : Bool?

      def_equals id
    end
  end
end
