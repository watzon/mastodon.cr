module Mastodon
  module Entities
    class Relationship
      include JSON::Serializable

      property id : String

      property following : Bool

      property requested : Bool

      property endorsed : Bool

      property followed_by : Bool

      property muting : Bool

      property muting_notifications : Bool

      property showing_reblogs : Bool

      property notifying : Bool

      property blocking : Bool

      property domain_blocking : Bool

      property blocked_by : Bool

      property note : String
    end
  end
end
