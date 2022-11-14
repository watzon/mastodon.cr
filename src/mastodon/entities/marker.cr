module Mastodon
  module Entities
    class Marker
      include JSON::Serializable

      property home : Marker::Info

      property title : Marker::Info

      class Info
        include JSON::Serializable

        property last_read_id : String

        property version : Int32

        @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
        property updated_at : Time
      end
    end
  end
end
