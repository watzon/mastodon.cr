module Mastodon
  module Entities
    class Error
      include JSON::Serializable

      property error : String

      property error_description : String?
    end
  end
end
