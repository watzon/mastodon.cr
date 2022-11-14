module Mastodon
  module Entities
    class Card
      include JSON::Serializable

      property url : String

      property title : String

      property description : String

      # TODO: Make enum
      property type : String # "link", "photo", "video", "rich"

      property author_name : String?

      property author_url : String?

      property provider_name : String?

      property provider_url : String?

      property html : String?

      property width : Int32?

      property height : Int32?

      property image : String?

      property embed_url : String?

      property blurhash : String?
    end
  end
end
