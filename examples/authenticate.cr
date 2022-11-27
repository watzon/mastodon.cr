require "./src/mastodon"

HOST          = "mastodon.social"
CLIENT_ID     = "XXXXXXXXXXXXXXXXXXXXXX-XXXXXXXXXXXXXXXXXXXXXX"
CLIENT_SECRET = "XXXXXXXXXXXXXXXXXXXXXX-XXXXXXXXXXXXXXXXXXXXXX"

client = Mastodon::API::Client.new(HOST)
auth_uri = client.authorize_uri(CLIENT_ID, "read write")

puts "Authenticate with #{auth_uri}"
print "Enter the code here: "

code = gets.try &.chomp

token = client.get_access_token_using_authorization_code(CLIENT_ID, CLIENT_SECRET, "read write", code)

puts "Access token: #{token.access_token}"
