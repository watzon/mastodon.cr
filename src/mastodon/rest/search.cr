require "http/client"
require "json"

module Mastodon
  module REST
    module Search
      private SEARCH_BASE = "/api/v1/search"

      def search(
        query,
        account_id = nil,
        max_id = nil,
        min_id = nil,
        type = nil,
        exclude_unreviewed = false,
        resolve = false,
        limit = 20,
        offset = 0,
        following = false
      )
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "q", "#{query}"
          param.add "account_id", "#{account_id}" if account_id
          param.add "max_id", "#{max_id}" if max_id
          param.add "min_id", "#{min_id}" if min_id
          param.add "type", "#{type}" if type
          param.add "exclude_unreviewed", "" if exclude_unreviewed
          param.add "resolve", "" if resolve
          param.add "limit", "#{limit}" if limit
          param.add "offset", "#{offset}" if offset
          param.add "following", "" if following
        end
        response = get("#{SEARCH_BASE}", params)
        Entities.from_response(response, Entities::Results)
      end
    end
  end
end
