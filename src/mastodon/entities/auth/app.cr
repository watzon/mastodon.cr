require "json"

module Mastodon
  module Entities
    module Auth
      class App
        include JSON::Serializable

        property id : Int64

        property redirect_uri : String

        property client_id : String

        property client_secret : String

        def_equals id
      end
    end
  end
end
