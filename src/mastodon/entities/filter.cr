module Mastodon
  module Entities
    class Filter
      include JSON::Serializable

      property id : String

      property phrase : String

      property context : Array(String)

      property whole_word : Bool

      property expires_at : String

      property irreversible : Bool
    end
  end
end
