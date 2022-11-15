module Mastodon
  module REST
    module Markers
      private MARKERS_BASE = "/api/v1/markers"

      def markers
        response = get(MARKERS_BASE)
        Entities.from_response(response, Collection(Entities::Marker))
      end

      def add_notification_marker(last_read_id)
        response = post(MARKERS_BASE, { notifications: { last_read_id: last_read_id } })
        Entities.from_response(response, Entities::Marker)
      end

      def add_home_marker(last_read_id)
        response = post(MARKERS_BASE, { home: { last_read_id: last_read_id } })
        Entities.from_response(response, Entities::Marker)
      end
    end
  end
end
