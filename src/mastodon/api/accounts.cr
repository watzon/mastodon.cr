module Mastodon
  module API
    module Accounts
      private ACCOUNTS_BASE = "/api/v1/accounts"

      def register_account(username, email, password, agreement = true, locale = "en", reason = nil)
        post(ACCOUNTS_BASE, {
          username:  username,
          email:     email,
          password:  password,
          agreement: agreement,
          locale:    locale,
          reason:    reason,
        })
        nil
      end

      def verify_credentials
        response = get("#{ACCOUNTS_BASE}/verify_credentials")
        Entities.from_response(response, Entities::Account)
      end

      def update_credentials(display_name = "", note = "", avatar = "", header = "")
        # avatar & header : image/jpeg, image/png, image/gif
        form_data = Utils::MultipartFormData.new
        form_data.add("display_name", "#{display_name}") unless display_name.empty?
        form_data.add("note", "#{note}") unless note.empty?
        unless avatar.empty?
          raise ArgumentError.new("File not found") unless File.file?(avatar)
          File.open(avatar, "rb") do |file|
            form_data.add_file("avatar", File.basename(avatar), file)
          end
        end
        unless header.empty?
          raise ArgumentError.new("File not found") unless File.file?(header)
          File.open(header, "rb") do |file|
            form_data.add_file("header", File.basename(header), file)
          end
        end
        form_data.finish
        response = patch_formdata("#{ACCOUNTS_BASE}/update_credentials", form_data)
        Entities.from_response(response, Entities::Account)
      end

      def account(id)
        response = get("#{ACCOUNTS_BASE}/#{id}")
        Entities.from_response(response, Entities::Account)
      end

      def statuses(id, only_media = false, exclude_replies = false, max_id = nil, since_id = nil, limit = DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "only_media", "" if only_media
          param.add "exclude_replies", "" if exclude_replies
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= DEFAULT_STATUSES_LIMIT * 2
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/statuses", params)
        Entities.from_response(response, Collection(Entities::Status))
      end

      def followers(id, max_id = nil, since_id = nil, limit = DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= DEFAULT_ACCOUNTS_LIMIT * 2
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/followers", params)
        Entities.from_response(response, Collection(Entities::Account))
      end

      def following(id, max_id = nil, since_id = nil, limit = DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= DEFAULT_ACCOUNTS_LIMIT * 2
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/following")
        Entities.from_response(response, Collection(Entities::Account))
      end

      def featured_tags(id)
        response = get("#{ACCOUNTS_BASE}/#{id}/featured_tags")
        Entities.from_response(response, Collection(Entities::Tag))
      end

      def lists(id)
        response = get("#{ACCOUNTS_BASE}/#{id}/lists")
        Entities.from_response(response, Collection(Entities::List))
      end

      def identity_proofs(id)
        response = get("#{ACCOUNTS_BASE}/#{id}/identity_proofs")
        Entities.from_response(response, Collection(Entities::IdentityProof))
      end

      {% for method in {"follow", "unfollow", "block", "unblock", "unmute"} %}
      def {{ method.id }}_account(id)
        response = post("#{ACCOUNTS_BASE}/#{id}/{{ method.id }}")
        Entities.from_response(response, Entities::Relationship)
      end
      {% end %}

      def mute_account(id, notifications = true, duration = 0)
        response = post("#{ACCOUNTS_BASE}/#{id}/mute", {
          notifications: notifications,
          duration:      duration,
        })
        Entities.from_response(response, Entities::Relationship)
      end

      def add_note(id, comment)
        response = post("#{ACCOUNTS_BASE}/#{id}/note", {comment: comment})
        Entities.from_response(response, Entities::Relationship)
      end

      def relationships(ids : Int32 | Array(Int32))
        params = HTTP::Params.build do |param|
          param.add "id[]", "#{ids}" if ids.is_a?(Int32)
          ids.map { |id| param.add "id[]", "#{id}" } if ids.is_a?(Array(Int32))
        end
        response = get("#{ACCOUNTS_BASE}/relationships", params)
        Entities.from_response(response, Collection(Entities::Relationship))
      end

      def search_accounts(query, limit = DEFAULT_ACCOUNTS_LIMIT, resolve = false, following = false)
        params = HTTP::Params.build do |param|
          param.add "q", query
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= DEFAULT_ACCOUNTS_LIMIT * 2
          param.add "resolve", "" if resolve
          param.add "following", "" if following
        end
        response = get("#{ACCOUNTS_BASE}/search", params)
        Entities.from_response(response, Collection(Entities::Account))
      end
    end
  end
end
