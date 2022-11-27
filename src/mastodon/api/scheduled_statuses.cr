module Mastodon
  module API
    module ScheduledStatuses
      private SCHEDULED_STATUSES_BASE = "/api/v1/scheduled_statuses"

      def scheduled_statuses(limit = 20, max_id = nil, since_id = nil, min_id = nil)
        response = get(SCHEDULED_STATUSES_BASE, {limit: limit, max_id: max_id, since_id: since_id, min_id: min_id})
        Entities.from_response(response, Collection(Entities::ScheduledStatus))
      end

      def scheduled_status(id)
        response = get("#{SCHEDULED_STATUSES_BASE}/#{id}")
        Entities.from_response(response, Entities::ScheduledStatus)
      end

      def create_scheduled_status(status, scheduled_at)
        response = put(SCHEDULED_STATUSES_BASE, {status: status, scheduled_at: scheduled_at})
        Entities.from_response(response, Entities::ScheduledStatus)
      end

      def cancel_scheduled_status(id)
        delete("#{SCHEDULED_STATUSES_BASE}/#{id}")
        nil
      end
    end
  end
end
