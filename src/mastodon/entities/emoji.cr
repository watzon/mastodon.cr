module Mastodon
  module Entities
    class Emoji
      include JSON::Serializable

      property shortcode : String

      property url : String

      property static_url : String

      property visible_in_picker : Bool

      property category : String?
    end
  end
end
