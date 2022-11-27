require "../spec_helper"

describe Mastodon::Client do
  client = Mastodon::Client.new(url: "example.com")

  describe "#new" do
    it "is a Mastodon::Client" do
      client.should be_a Mastodon::Client
    end

    describe "#access_token" do
      context "without access token" do
        it "is nil" do
          client.access_token?.should be_nil
        end
      end

      context "with access token string" do
        it "is a OAuth2::AccessToken::Bearer" do
          client = Mastodon::Client.new(url: "example.com", access_token: "TOKEN")
          client.access_token?.should be_a OAuth2::AccessToken::Bearer
          client.access_token.access_token.should eq "TOKEN"
        end
      end

      describe "with access token object" do
        it "is a OAuth2::AccessToken::Bearer" do
          bearer_token = OAuth2::AccessToken::Bearer.new(access_token: "TOKEN", expires_in: nil)
          client = Mastodon::Client.new(url: "example.com", access_token: bearer_token)
          client.access_token?.should be_a OAuth2::AccessToken::Bearer
          client.access_token.access_token.should eq "TOKEN"
        end
      end
    end

    describe "#user_agent" do
      it "is equal `mastodon.cr/<version>`" do
        client.user_agent.should eq "mastodon.cr/#{Mastodon::VERSION}"
      end
    end
  end

  describe "#get" do
    describe "without parametors" do
      before_each do
        WebMock.stub(:get, "https://example.com/get")
          .to_return(body: "ok")
      end

      it "request success" do
        client.get("/get").should eq "ok"
      end
    end

    describe "with parametors string" do
      before_each do
        WebMock.stub(:get, "https://example.com/get")
          .with(query: {"param1" => "1", "param2" => "2"})
          .to_return(body: "ok")
      end

      it "request success" do
        client.get("/get", "param1=1&param2=2").should eq "ok"
      end
    end

    describe "with parametors hash" do
      before_each do
        WebMock.stub(:get, "https://example.com/get")
          .with(query: {"param1" => "1", "param2" => "2"})
          .to_return(body: "ok")
      end

      it "request success" do
        client.get("/get", {"param1" => "1", "param2" => "2"}).should eq "ok"
      end
    end
  end

  describe "#post" do
    describe "without parametors" do
      before_each do
        WebMock.stub(:post, "https://example.com/post")
          .to_return(body: "ok")
      end

      it "request success" do
        client.post("/post").should eq "ok"
      end
    end

    describe "with parametors string" do
      before_each do
        WebMock.stub(:post, "https://example.com/post")
          .with(body: "param1=1&param2=2")
          .to_return(body: "ok")
      end

      it "request success" do
        client.post("/post", "param1=1&param2=2").should eq "ok"
      end
    end

    describe "with parametors hash" do
      before_each do
        WebMock.stub(:post, "https://example.com/post")
          .with(body: "param1=1&param2=2")
          .to_return(body: "ok")
      end

      it "request success" do
        client.post("/post", {"param1" => "1", "param2" => "2"}).should eq "ok"
      end
    end
  end

  describe "#patch" do
    describe "without parametors" do
      before_each do
        WebMock.stub(:patch, "https://example.com/patch")
          .to_return(body: "ok")
      end

      it "request success" do
        client.patch("/patch").should eq "ok"
      end
    end

    describe "with parametors string" do
      before_each do
        WebMock.stub(:patch, "https://example.com/patch")
          .with(body: "param1=1&param2=2")
          .to_return(body: "ok")
      end

      it "request success" do
        client.patch("/patch", "param1=1&param2=2").should eq "ok"
      end
    end

    describe "with parametors hash" do
      before_each do
        WebMock.stub(:patch, "https://example.com/patch")
          .with(body: "param1=1&param2=2").to_return(body: "ok")
      end

      it "request success" do
        client.patch("/patch", {"param1" => "1", "param2" => "2"}).should eq "ok"
      end
    end
  end

  describe "#delete" do
    before_each do
      WebMock.stub(:delete, "https://example.com/delete")
        .to_return(body: "ok")
    end

    it "request success" do
      client.delete("/delete").should eq "ok"
    end
  end
end
