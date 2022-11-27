require "http/client"
require "oauth2"
require "log"

require "./api"

module Mastodon
  class Client
    include API

    Log = ::Log.for(self)

    getter url : String
    getter! access_token : OAuth2::AccessToken::Bearer?
    property user_agent : String = "mastodon.cr/#{Mastodon::VERSION}"

    def initialize(url : String)
      @url = url
      @http_client = HTTP::Client.new(@url, tls: true)
    end

    def initialize(url : String, access_token : String | OAuth2::AccessToken::Bearer)
      @url = url
      @http_client = HTTP::Client.new(@url, tls: true)
      authenticate(access_token)
    end

    def authenticate(access_token : String)
      @access_token = OAuth2::AccessToken::Bearer.new(access_token, 172_800)
      @access_token.not_nil!.authenticate(@http_client)
    end

    def authenticate(access_token : OAuth2::AccessToken::Bearer)
      @access_token = access_token
      access_token.authenticate(@http_client)
    end

    def get(path : String, params : String | Hash(String, String) = "")
      params = params.to_h.transform_keys(&.to_s).transform_values(&.to_s) if (params.is_a?(Hash) || params.is_a?(NamedTuple))
      params = HTTP::Params.encode(params) if params.is_a?(Hash)
      path += "?#{params}" unless params.empty?
      response = @http_client.get(path, default_headers)
      proccess_response(response)
    end

    def post(path : String, form : String | Hash | NamedTuple = "")
      form = form.to_h.transform_keys(&.to_s).transform_values(&.to_s) if (form.is_a?(Hash) || form.is_a?(NamedTuple))
      response = @http_client.post(path, form: form, headers: default_headers)
      proccess_response(response)
    end

    def put(path : String, form : String | Hash | NamedTuple = "")
      form = form.to_h.transform_keys(&.to_s).transform_values(&.to_s) if (form.is_a?(Hash) || form.is_a?(NamedTuple))
      response = @http_client.put(path, form: form, headers: default_headers)
      proccess_response(response)
    end

    def post_formdata(path : String, form_data : Utils::MultipartFormData)
      headers = HTTP::Headers{
        "Content-Length" => "#{form_data.size}",
        "Content-Type"   => "#{form_data.content_type}",
      }
      response = @http_client.post(path, headers.merge!(default_headers), form_data.io.to_slice)
      proccess_response(response)
    end

    def patch(path : String, form : String | Hash | NamedTuple = "")
      form = form.to_h.transform_keys(&.to_s).transform_values(&.to_s) if (form.is_a?(Hash) || form.is_a?(NamedTuple))
      form = HTTP::Params.encode(form) if form.is_a?(Hash)
      headers = HTTP::Headers{"Content-type" => "application/x-www-form-urlencoded"}
      response = @http_client.patch(path, headers.merge!(default_headers), form)
      proccess_response(response)
    end

    def patch_formdata(path : String, form_data : Utils::MultipartFormData)
      headers = HTTP::Headers{
        "Content-Length" => "#{form_data.size}",
        "Content-Type"   => "#{form_data.content_type}",
      }
      response = @http_client.patch(path, headers.merge!(default_headers), form_data.io.to_slice)
      proccess_response(response)
    end

    def delete(path : String, form : String | Hash | NamedTuple = "")
      form = form.to_h.transform_keys(&.to_s).transform_values(&.to_s) if (form.is_a?(Hash) || form.is_a?(NamedTuple))
      form = HTTP::Params.encode(form) if form.is_a?(Hash)
      headers = HTTP::Headers{"Content-type" => "application/x-www-form-urlencoded"}
      response = @http_client.delete(path, headers.merge!(default_headers), form)
      proccess_response(response)
    end

    private def proccess_response(response : HTTP::Client::Response)
      case response.status_code
      when 200..299
        return response.body
      else
        raise Error.new(response)
      end
    end

    private def default_headers
      HTTP::Headers{"User-Agent" => "#{@user_agent}"}
    end
  end
end
