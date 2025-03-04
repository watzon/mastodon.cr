module Mastodon
  module Entities
    class Results
      include JSON::Serializable

      property accounts : Array(Account)

      property statuses : Array(Status)

      property hashtags : Array(Tag)
    end
  end
end
