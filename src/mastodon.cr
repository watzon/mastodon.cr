require "json"
require "http/client"

require "./mastodon/*"
require "./mastodon/utils/**"
require "./mastodon/rest/**"
require "./mastodon/streaming/**"

module Mastodon
  DEFAULT_ACCOUNTS_LIMIT      = 40
  DEFAULT_STATUSES_LIMIT      = 20
  DEFAULT_NOTIFICATIONS_LIMIT = 15
end
