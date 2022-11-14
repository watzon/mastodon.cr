module Mastodon
  module Entities
    class Conversation
      include JSON::Serializable

      property id : String

      property accounts : Array(Account)

      property unread : Bool

      property last_status : Status?
    end
  end
end
