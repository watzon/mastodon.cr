module Mastodon
  module Entities
    class Application
      include JSON::Serializable

      property name : String

      property website : String?

      property vapid_key : String?

      property client_id : String?

      property client_secret : String?
    end
  end
end
