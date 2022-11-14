module Mastodon
  module Entities
    class List
      include JSON::Serializable

      property id : String

      property title : String

      # TODO: Make enum
      property replies_policy : String # "followed", "list", "none"
    end
  end
end
