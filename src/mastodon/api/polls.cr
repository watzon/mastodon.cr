module Mastodon
  module API
    module Polls
      private POLLS_BASE = "/api/v1/polls"

      def poll(id)
        # Does not require authentication
        response = get("#{POLLS_BASE}/#{id}")
        Entities.from_response(response, Entities::Poll)
      end

      def poll_vote(id, choices)
        choices = choices.is_a?(Array) ? choices : [choices]
        response = post("#{POLLS_BASE}/#{id}/votes", {choices: choices})
        Entities.from_response(response, Entities::Poll)
      end
    end
  end
end
