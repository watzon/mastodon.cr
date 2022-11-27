require "http/client"
require "json"

module Mastodon
  module API
    module Announcements
      private ANNOUNCEMENTS_BASE = "/api/v1/announcements"

      def announcements(with_dismissed = false)
        response = get(ANNOUNCEMENTS_BASE, {with_dismissed: with_dismissed})
        Entities.from_response(response, Collection(Entities::Announcement))
      end

      def dismiss_announcement(id)
        post("#{ANNOUNCEMENTS_BASE}/#{id}/dismiss")
        nil
      end

      def add_reaction_to_announcement(id, name)
        put("#{ANNOUNCEMENTS_BASE}/#{id}/reactions", {name: name})
        nil
      end

      def remove_reaction_from_announcement(id, name)
        delete("#{ANNOUNCEMENTS_BASE}/#{id}/reactions", {name: name})
        nil
      end
    end
  end
end
