module Mastodon
  module Entities
    class Context
      include JSON::Serializable

      property ancestors : Array(Status)

      property descendants : Array(Status)
    end
  end
end
