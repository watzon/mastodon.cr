module Mastodon
  module REST
    module Lists
      private LISTS_BASE = "/api/v1/lists"

      def lists
        response = get(LISTS_BASE)
        Entities.from_response(response, Collection(Entities::List))
      end

      def list(id)
        response = get("#{LISTS_BASE}/#{id}")
        Entities.from_response(response, Entities::List)
      end

      def create_list(title, replies_policy = "list")
        response = post(LISTS_BASE, { title: title, replies_policy: replies_policy })
        Entities.from_response(response, Entities::List)
      end

      def update_list(id, title = nil, replies_policy = "list")
        response = put("#{LISTS_BASE}/#{id}", { title: title, replies_policy: replies_policy })
        Entities.from_response(response, Entities::List)
      end

      def delete_list(id)
        delete("#{LISTS_BASE}/#{id}")
        nil
      end

      def list_accounts(id, limit = 40, max_id = nil, since_id = nil)
        response = get("#{LISTS_BASE}/#{id}/accounts", { limit: limit, max_id: max_id, since_id: since_id })
        Entities.from_response(response, Collection(Entities::Account))
      end

      def add_list_accounts(id, account_ids)
        post("#{LISTS_BASE}/#{id}/accounts", { account_ids: account_ids })
        nil
      end

      def remove_list_accounts(id, account_ids)
        delete("#{LISTS_BASE}/#{id}/accounts", { account_ids: account_ids })
        nil
      end
    end
  end
end
