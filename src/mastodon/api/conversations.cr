module Mastodon
  module API
    module Conversations
      private CONVERSATIONS_BASE = "/api/v1/conversations"

      def conversation(id, limit = 20, max_id = nil, since_id = nil, min_id = nil)
        response = get("#{CONVERSATIONS_BASE}/#{id}", {limit: limit, max_id: max_id, since_id: since_id, min_id: min_id})
        Entities.from_response(response, Collection(Entities::Conversation))
      end

      def delete_conversation(id)
        delete("#{CONVERSATIONS_BASE}/#{id}")
        nil
      end

      def mark_conversation_read(id)
        post("#{CONVERSATIONS_BASE}/#{id}/read")
        nil
      end
    end
  end
end
