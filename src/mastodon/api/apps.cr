require "http/client"
require "json"

module Mastodon
  module API
    module Apps
      private APPS_BASE = "/api/v1/apps"

      def apps(client_name, redirect_uris = "urn:ietf:wg:oauth:2.0:oob", scopes = "read", website = nil)
        response = post("#{APPS_BASE}", {
          client_name:   client_name,
          redirect_uris: redirect_uris,
          scopes:        scopes,
          website:       website,
        })
        Entities.from_response(response, Entities::Auth::App)
      end

      def verify_app_credentials
        response = get("#{APPS_BASE}/verify_credentials")
        Entities.from_response(response, Entities::Auth::App)
      end
    end
  end
end
