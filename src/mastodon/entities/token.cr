module Mastodon
  module Entities
    class Token
      include JSON::Serializable

      property access_token : String

      property token_type : String

      property scope : String

      @[JSON::Field(converter: Time::EpochConverter)]
      property created_at : Time
    end
  end
end
