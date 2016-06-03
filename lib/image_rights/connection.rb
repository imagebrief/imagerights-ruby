require 'faraday'
require 'json'
require 'open-uri'

module ImageRights
  class Connection 
    
    def self.post(endpoint, params)
      params = process_image_param(params)
      response = connection.post(endpoint, pk_with_params(params))
      parse_for_errors(response)
      response
    end

    def self.get(endpoint, params)
      response = connection.get(endpoint, pk_with_params(params))
      parse_for_errors(response)
      response
    end



    # Private Methods

    def self.connection
      connection = Faraday.new(:url => ImageRights::Configuration::DEFAULT_URL) do |faraday|
        faraday.request  :multipart
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  :net_http                # make requests with Net::HTTP
      end
    end
    private_class_method :connection


    def self.process_image_param(params)
      if !params[:image_file].nil?
        # get the param key and the filepath
        key = params[:image_file][:key]
        file_path = params[:image_file][:path]
        mime_type = params[:image_file][:mime_type]
        remote_path = params[:image_file][:remote_path]
        remote_filename = params[:image_file][:remote_filename]

        # remove old image_file key
        params.delete(:image_file)

        # add new key to params
        if remote_path  
          raise ImageRights::InvalidFilenameGiven if remote_filename.nil?
          params[key.to_sym] = Faraday::UploadIO.new(open(file_path), mime_type, remote_filename)
        else
          params[key.to_sym] = Faraday::UploadIO.new(file_path, mime_type)
        end
      end

      params
    end

    def self.pk_with_params(params)
      params.merge({ partner_key: ImageRights.configuration.partner_key })
    end
    private_class_method :pk_with_params

    def self.parse_for_errors(response)
      case response.status
      when 400
        case response.body
        when 'LOGIN_FAIL'
          raise ImageRights::InvalidAuthKey
        when 'BAD AUTH'
          raise ImageRights::InvalidPartnerKey
        # when 'BAD LEVEL'
          # raise ImageRights::InvalidPlanLevel
        else
          raise ImageRights::BadRequest
        end
      when 422 
        raise ImageRights::UnprocessableRequest
      when 503
        raise ImageRights::RateLimitExceeded
      end
    end
    private_class_method :parse_for_errors

  end
end