require "http/client"
require "json"

module Mastodon
  module API
    module Instances
      private INSTANCES_BASE = "/api/v1/instance"

      def instance
        # Does not require authentication
        response = get("#{INSTANCES_BASE}")
        Entities.from_response(response, Entities::Instance)
      end

      def intance_peers
        # Does not require authentication
        response = get("#{INSTANCES_BASE}/peers")
        Entities.from_response(response, Collection(String))
      end

      def weekly_activity
        # Does not require authentication
        response = get("#{INSTANCES_BASE}/activity")
        Entities.from_response(response, Collection(Activity))
      end
    end
  end
end
