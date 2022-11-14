module Mastodon
  module Entities
    class PushSubscription
      include JSON::Serializable

      property id : Int32

      property endpoint : String

      property alerts : Alerts

      property server_key : String

      class Alerts
        include JSON::Serializable

        property follow : Bool

        property favourite : Bool

        property reblog : Bool

        property mention : Bool

        property poll : Bool
      end
    end
  end
end
