module Mastodon
  module API
    module Timelines
      private TIMELINES_BASE = "/api/v1/timelines"

      def timeline_home(max_id = nil, since_id = nil, min_id = nil, limit = DEFAULT_STATUSES_LIMIT, local = false)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "min_id", "#{min_id}" unless min_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= DEFAULT_STATUSES_LIMIT * 2
          param.add "local", "" if local
        end
        response = get("#{TIMELINES_BASE}/home", params)
        Entities.from_response(response, Collection(Entities::Status))
      end

      def timeline_public(
        local = false,
        remote = false,
        only_media = false,
        max_id = nil,
        since_id = nil,
        min_id = nil,
        limit = DEFAULT_STATUSES_LIMIT
      )
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
          param.add "remote", "" if remote
          param.add "only_media", "" if only_media
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "min_id", "#{min_id}" unless min_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= DEFAULT_STATUSES_LIMIT * 2
        end
        response = get("#{TIMELINES_BASE}/public", params)
        Entities.from_response(response, Collection(Entities::Status))
      end

      def timeline_tag(
        hashtag,
        local = false,
        only_media = false,
        max_id = nil,
        since_id = nil,
        min_id = nil,
        limit = DEFAULT_STATUSES_LIMIT
      )
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
          param.add "only_media", "" if only_media
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "min_id", "#{min_id}" unless min_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= DEFAULT_STATUSES_LIMIT * 2
        end
        response = get("#{TIMELINES_BASE}/tag/#{hashtag}", params)
        Entities.from_response(response, Collection(Entities::Status))
      end

      def timeline_list(
        list_id,
        since_id = nil,
        min_id = nil,
        limit = DEFAULT_STATUSES_LIMIT
      )
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "min_id", "#{min_id}" unless min_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= DEFAULT_STATUSES_LIMIT * 2
        end
        response = get("#{TIMELINES_BASE}/list/#{list_id}", params)
        Entities.from_response(response, Collection(Entities::Status))
      end
    end
  end
end
