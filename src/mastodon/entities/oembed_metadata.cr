module Mastodon
  module Entities
    class OEmbedMetadata
      include JSON::Serializable

      property type : String

      property version : String

      property title : String

      property author_name : String

      property author_url : String

      property provider_name : String

      property provider_url : String

      property cache_age : Int32

      property html : String

      property width : Int32

      property height : Int32?
    end
  end
end
