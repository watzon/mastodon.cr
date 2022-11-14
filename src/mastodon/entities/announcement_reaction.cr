module Mastodon
  module Entities
    class AnnouncementReaction
      include JSON::Serializable

      property name : String

      property count : Int32

      property me : Bool

      property url : String?

      property static_url : String?
    end
  end
end
