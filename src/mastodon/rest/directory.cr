require "http/client"
require "json"

module Mastodon
  module REST
    module Directory
      private DIRECTORIES_BASE = "/api/v1/directory"

      def directory(offset = 0, limit = 40, order = "active", local = false)
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "offset", offset unless offset.nil?
          param.add "limit", limit unless limit.nil?
          param.add "order", order if order
          param.add "local", "" if local
        end
        response = get(DIRECTORIES_BASE, params)
        Entities.from_response(response, Collection(Entities::Account))
      end
    end
  end
end
