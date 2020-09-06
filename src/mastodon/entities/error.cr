require "json"

module Mastodon
  module Entities
    class Error
      include JSON::Serializable

      @[JSON::Field(key: "error")]
      property error : String
    end
  end
end
