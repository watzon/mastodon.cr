module Mastodon
  module Entities
    class Preferences
      include JSON::Serializable

      @[JSON::Field(key: "posting:default:visibility")]
      property posting_default_visibility : String

      @[JSON::Field(key: "posting:default:sensitive")]
      property posting_default_sensitive : Bool

      @[JSON::Field(key: "posting:default:language")]
      property posting_default_language : String

      # TODO: Make enum
      @[JSON::Field(key: "reading:expand:media")]
      property reading_expand_media : String # "default", "show_all", "hide_all"

      @[JSON::Field(key: "reading:expand:spoilers")]
      property reading_expand_spoilers : Bool
    end
  end
end
