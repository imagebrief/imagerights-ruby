require './test/test_helper'

describe ImageRights::Image do
  before do 
    @test_auth_key = "IB.13394.7EF303DB20115CA51420B84E"
    @test_image_id = "3809193"
    @user = ImageRights::User.new(@test_auth_key)
  end

  describe "uploading an image" do 
    before do 
      @image_path = FIXTURES_PATH + '/flatiron.jpg'
      @mime_type = 'image/jpg'

      @optional_fields = {
        mime_type: @mime_type,
        imageset: 'test set'
      }

      VCR.use_cassette('upload_image') do
        @image = ImageRights::Image.upload_image(@user, @image_path, @optional_fields)
      end
    end

    it "should save the ImageRights id to the image object" do 
      @image.image_id.must_equal @test_image_id
    end
  end

  describe "uploading an image from a remote path" do 
    before do 
      @image_path = "http://d26h94e2ysv9hi.cloudfront.net/images/55628b18c5906dc7e100001f/resized_1024_487386_566103.jpg"
      @mime_type = 'image/jpg'

      @optional_fields = {
        mime_type: @mime_type,
        imageset: 'test set',
        remote_path: true,
        remote_filename: "IMG-12345-678910.jpg"
      }

      VCR.use_cassette('upload_image_remote') do
        @image = ImageRights::Image.upload_image(@user, @image_path, @optional_fields)
      end
    end

    it "should save the ImageRights id to the image object" do 
      # @image.image_id.must_equal @test_image_id
    end
  end

  describe "deleting an image" do 
    it "should return true confirming the image from ImageRights" do 
      @image = ImageRights::Image.new(@user, @test_image_id)

      VCR.use_cassette('delete_image') do
        @image.delete.must_equal true
      end
    end
  end

end
