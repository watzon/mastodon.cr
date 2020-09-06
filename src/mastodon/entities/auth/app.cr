require "json"

module Mastodon
  module Entities
    module Auth
      class App
        include JSON::Serializable

        @[JSON::Field(key: "id")]
        property id : Int64

        @[JSON::Field(key: "redirect_uri")]
        property redirect_uri : String

        @[JSON::Field(key: "client_id")]
        property client_id : String

        @[JSON::Field(key: "client_secret")]
        property client_secret : String

        def_equals id
      end
    end
  end
end
