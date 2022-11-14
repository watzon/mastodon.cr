module Mastodon
  module Entities
    class Account
      include JSON::Serializable

      property id : String

      property username : String

      property acct : String

      property display_name : String

      property locked : Bool

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property created_at : Time

      property followers_count : Int32

      property following_count : Int32

      property statuses_count : Int32

      property note : String

      property url : String

      property avatar : String

      property avatar_static : String

      property header : String

      property header_static : String

      def_equals id
    end
  end
end
