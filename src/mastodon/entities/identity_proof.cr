module Mastodon
  module Entities
    class IdentityProof
      include JSON::Serializable

      property provider : String

      property provider_username : String

      property profile_url : String

      property proof_url : String

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property updated_at : Time
    end
  end
end
