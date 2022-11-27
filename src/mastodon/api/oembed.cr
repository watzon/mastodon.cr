require "http/client"
require "json"

module Mastodon
  module API
    module OEmbed
      private OEMBED_BASE = "/api/v1/oembed"

      def oembed(url, maxwidth = nil, maxheight = nil)
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "url", url
          param.add "maxwidth", maxwidth unless maxwidth.nil?
          param.add "maxheight", maxheight unless maxheight.nil?
        end
        response = get(OEMBED_BASE, params)
        Entities.from_response(response, Entities::OEmbedMetadata)
      end
    end
  end
end
