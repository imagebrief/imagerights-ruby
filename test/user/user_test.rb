require './test/test_helper'

describe ImageRights::User do

  before do 
    @test_auth_key = "IB.13394.7EF303DB20115CA51420B84E"
  end

  describe "when instantiating a new user" do 
    before do 
      @user = ImageRights::User.new('abc')
    end

    it "must have an auth_key" do
      @user.auth_key.must_equal 'abc'
    end
  end

  describe "when creating a new account" do
    describe "with correct data" do
      before do 
        VCR.use_cassette('create_user') do
          @user = ImageRights::User.create_account({first_name: "Test", last_name: "Person", email: "harry+irtest@imagebrief.com"})
        end
      end

      it "must store the auth token on the user" do
        @user.class.must_equal ImageRights::User
        @user.auth_key.must_equal @test_auth_key
      end
    end

    describe "with incomplete data" do
      it "must raise a bad request error" do
        assert_raises ImageRights::BadRequest do 
          VCR.use_cassette('create_incomplete_user') do
            ImageRights::User.create_account({first_name: "Test", last_name: "Person"})
          end
        end
      end
    end
  end

  describe "when retrieving a login url" do 
    before do 
      @user = ImageRights::User.new(@test_auth_key)

      VCR.use_cassette('get_login_url') do 
        @login_url = @user.get_login_url
      end
    end

    it "should be a string" do 
      @login_url.class.must_equal String
    end
  end

  describe "when verifying an authorization key" do 
    describe "when valid" do
      before do 
        @user = ImageRights::User.new(@test_auth_key)

        VCR.use_cassette('verify_login_valid') do 
          @valid = @user.verify_login
        end
      end

      it "should return true" do 
        @valid.must_equal true
      end
    end

    describe "when invalid" do
      before do 
        @user = ImageRights::User.new("xyz")

        VCR.use_cassette('verify_login_invalid') do 
          @valid = @user.verify_login
        end
      end

      it "should return false" do 
        @valid.must_equal false
      end
    end
  end

  describe "when setting plan level" do 
    before do 
      @user = ImageRights::User.new(@test_auth_key)
    end

    describe "when setting to a valid plan level" do 
      before do 
        VCR.use_cassette('set_valid_plan') do 
          @plan_changed = @user.set_account_level("basic")
        end
      end

      it "should return a true confirmation" do
        @plan_changed.must_equal true
      end
    end

    it "must raise a bad request error" do
      assert_raises ImageRights::BadRequest do 
        VCR.use_cassette('set_invalid_plan') do
          @user.set_account_level("balderdash")
        end
      end
    end

  end

  describe "when uploading an image" do 
    before do 
      @user = ImageRights::User.new(@test_auth_key)

      @image_path = FIXTURES_PATH + '/flatiron.jpg'
      @mime_type = 'image/jpg'

      @optional_fields = {
        mime_type: @mime_type,
        imageset: 'test set'
      }

      VCR.use_cassette('upload_image') do
        @image = @user.upload_image(@image_path, @optional_fields)
      end
    end

    it "should save the ImageRights id to the image object" do 
      # @image.image_id.must_equal @test_image_id
    end
  end
end

