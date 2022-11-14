module Mastodon
  module Entities
    class Instance
      include JSON::Serializable

      property uri : String

      property title : String

      property description : String

      property short_description : String

      property email : String

      property version : String

      property languages : Array(String)

      property registrations : Bool

      property approval_required : Bool

      property invites_enabled : Bool

      property urls : Hash(String, String)

      property stats : Hash(String, Int32)

      property thumbnail : String?

      property contact_account : Account?
    end
  end
end
