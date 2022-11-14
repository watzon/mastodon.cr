module Mastodon
  module Entities
    class History
      include JSON::Serializable

      property day : String

      property uses : String

      property accounts : String
    end
  end
end
