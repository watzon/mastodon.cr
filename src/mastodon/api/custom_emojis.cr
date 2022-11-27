require "http/client"
require "json"

module Mastodon
  module API
    module CustomEmojis
      private CUSTOM_EMOJIS_BASE = "/api/v1/custom_emojis"

      def custom_emojis
        # Does not require authentication
        response = get(CUSTOM_EMOJIS_BASE)
        Entities.from_response(response, Collection(Entities::Emoji))
      end
    end
  end
end
