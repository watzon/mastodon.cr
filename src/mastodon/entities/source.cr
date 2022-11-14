module Mastodon
  module Entities
    class Source
      include JSON::Serializable

      # TODO: Make enum
      property privacy : String # "public", "unlisted", "private", "direct"

      property sensitive : Bool

      property language : String

      property note : String

      property fields : Array(Field)

      property follow_requests_count : Int32
    end
  end
end
