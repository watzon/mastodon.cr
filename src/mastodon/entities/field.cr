module Mastodon
  module Entities
    class Field
      include JSON::Serializable

      property name : String

      property value : String

      @[JSON::Field(converter: Time::Format.new("%Y-%m-%dT%T"))]
      property verified_at : Time?
    end
  end
end
