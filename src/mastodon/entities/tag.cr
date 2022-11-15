module Mastodon
  module Entities
    class Tag
      include JSON::Serializable

      property name : String

      property url : String

      property history : Array(History) = [] of History
    end
  end
end
