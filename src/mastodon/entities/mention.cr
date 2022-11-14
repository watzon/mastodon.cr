module Mastodon
  module Entities
    class Mention
      include JSON::Serializable

      property url : String

      property username : String

      property acct : String

      property id : String
    end
  end
end
