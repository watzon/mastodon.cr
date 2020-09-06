require "json"

module Mastodon
  module Entities
    module Auth
      class AccessToken
        include JSON::Serializable

        @[JSON::Field(key: "access_token")]
        property access_token : String

        @[JSON::Field(key: "token_type")]
        property token_type : String

        @[JSON::Field(key: "scope")]
        property scope : String

        @[JSON::Field(key: "created_at")]
        property created_at : Int64
      end
    end
  end
end
