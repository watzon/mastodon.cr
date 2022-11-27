require "./api/**"

module Mastodon
  module API
    include API::Accounts
    include API::Announcements
    include API::Apps
    include API::Blocks
    include API::Conversations
    include API::CustomEmojis
    include API::Directory
    include API::DomainBlocks
    include API::Favourites
    include API::FollowRequests
    include API::Follows
    include API::Instances
    include API::Lists
    include API::Markers
    include API::Media
    include API::Mutes
    include API::Notifications
    include API::OEmbed
    include API::Polls
    include API::OAuth
    include API::Reports
    include API::ScheduledStatuses
    include API::Search
    include API::Streaming
    include API::Statuses
    include API::Timelines
    include API::Trends
  end
end
