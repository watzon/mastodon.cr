require "../spec_helper"

describe Mastodon::Error do
  describe "#message" do
    it "is equal HTTP status code and message" do
      Mastodon::Error.new(HTTP::Client::Response.new(404)).message.should eq "404 Not Found"
    end
  end
end
