module ImageRights
  class Image
    attr_reader :user, :image_id

    def initialize(user, image_id)
      @image_id = image_id
      @user = user
    end

    def delete
      response = ImageRights::Connection.post('delete', {auth_key: user.auth_key, image_id: image_id})
      return response.body == 'OK'
    end

    # Class methods

    def self.upload_image(user, path, optional_fields={})
      # image_file param is converted to a file upload type by the connection class
      
      params = {
        auth_key: user.auth_key,
        imageset: (optional_fields[:imageset] || 'api_upload'),
        image_file: {
          key: 'image', 
          path: path,
          mime_type: (optional_fields[:mime_type] || 'image/jpg')
        }
      }

      response = ImageRights::Connection.post('upload_image', params)
      image_id = response.body.split[1]
      return ImageRights::Image.new(user, image_id)
    end
  end
end