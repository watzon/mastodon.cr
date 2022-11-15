require "http/client"
require "json"

module Mastodon
  module REST
    module Trends
      private TRENDS_BASE = "/api/v1/trends"

      def trends(limit = 10)
        # Does not require authentication
        response = get(TRENDS_BASE)
        Entities.from_response(response, Collection(Entities::Tag))
      end
    end
  end
end
