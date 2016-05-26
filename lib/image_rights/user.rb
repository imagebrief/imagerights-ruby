module ImageRights
  class User
    attr_reader :auth_key

    def initialize(auth_key)
      @auth_key = auth_key
    end

    def get_login_url
      response = ImageRights::Connection.post('get_login_url', {auth_key: auth_key})
      return response.body
    end

    def verify_login
      response = ImageRights::Connection.post('verify_login', {auth_key: auth_key})
      return response.body == "OK"
    end

    def set_account_level(plan_name)
      response = ImageRights::Connection.post('set_account_level', {auth_key: auth_key, level: plan_name})
      return response.body == "OK"
    end

    def upload_image(path, optional_fields={})
      ImageRights::Image.upload_image(self, path, optional_fields)
    end

    def delete_image(image_id)
      image = ImageRights::Image.new(self, image_id)
      image.delete
    end

    def get_statistics
      response = ImageRights::Connection.get('get_statistics', {auth_key: auth_key})
    end

    # Class Methods

    def self.create_account(account_fields={})
      details = {first_name: account_fields[:first_name], 
                last_name: account_fields[:last_name],
                email: account_fields[:email]}
      response = ImageRights::Connection.post('make_get_account', details)
      auth_key = response.body
      return ImageRights::User.new(auth_key)
    end
  end
end