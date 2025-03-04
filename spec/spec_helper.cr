require "spec"
require "webmock"
require "../src/mastodon"

# Utils
def fixture_image(name)
  File.dirname(__FILE__) + "/fixtures/#{name}"
end

def load_fixture(name)
  File.read_lines(File.dirname(__FILE__) + "/fixtures/#{name}.json").join("\n")
end

def load_response(name)
  File.read_lines(File.dirname(__FILE__) + "/fixtures/#{name}.txt").join("\n")
end

def default_headers
  HTTP::Headers{
    "Authorization" => "Bearer token",
    "User-Agent"    => "mastodon.cr/#{Mastodon::VERSION}",
  }
end

# GET
def stub_get(path, fixture, params : String | Hash | NamedTuple = "")
  params = HTTP::Params.encode(params) if params.is_a?(Hash)
  path += "?#{params}" unless params.empty?
  WebMock.stub(:get, "https://example.com#{path}")
    .with(headers: default_headers)
    .to_return(body: load_fixture(fixture))
end

# POST
def stub_post(path, fixture = nil, body : String | Hash | NamedTuple = "")
  body = body.to_h.transform_keys(&.to_s).transform_values(&.to_s) if (body.is_a?(Hash) || body.is_a?(NamedTuple))
  body = HTTP::Params.encode(body) if body.is_a?(Hash)
  response_body = fixture.nil? ? "{}" : load_fixture(fixture)
  headers = HTTP::Headers{"Content-type" => "application/x-www-form-urlencoded"}
  WebMock.stub(:post, "https://example.com#{path}")
    .with(body: body, headers: headers.merge!(default_headers))
    .to_return(body: response_body)
end

def client
  Mastodon::Client.new("example.com", "token")
end
