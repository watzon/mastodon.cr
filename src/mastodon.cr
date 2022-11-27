require "json"
require "http/client"

require "./mastodon/version"
require "./mastodon/error"
require "./mastodon/collection"
require "./mastodon/utils/**"
require "./mastodon/entities"
require "./mastodon/client"

module Mastodon
  DEFAULT_ACCOUNTS_LIMIT      = 40
  DEFAULT_STATUSES_LIMIT      = 20
  DEFAULT_NOTIFICATIONS_LIMIT = 15
end
