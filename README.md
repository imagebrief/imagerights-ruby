# ImageRights Ruby

ImageRights provides a service for photographers to track unauthorised use of their images on the web. 

They rely on web crawlers to scan pages for visual matches on images that have been provided to them. When a sighting is made, the photographer is alerted and can decide whether or not to pursue a compensation claim. 

This ruby gem serves as a wrapper for their web API. This functionality encompasses: 

* Creating new users
* Setting or updating user plan levels
* Verifying auth tokens for existing users
* Generating one-time login URLs
* Uploading images
* Deleting existing images

## Installation

To get started, include the gem in your Gemfile

```ruby 
gem 'image_rights'
```
or 

```shell
gem install image_rights
```

## Usage

### Initialization

You will need to have a Partner Key provided to you by ImageRights. This is used to authenticate every request. 

You must initialize the library with this. 

```ruby 
ImageRights.configure do |c|
  c.partner_key = ENV["IMAGERIGHTS_TEST_KEY"]
end
```

### Creating up a new user account

This takes a hash containing, email and first and last name. A user with a valid auth key is returned.

```ruby 
ImageRights::User.create_account({email: 'test@example.com', first_name: 'Harry', last_name: 'Curotta'})
# => #<ImageRights::User:0x007ff224ac8c08 @auth_key="IB.13395.1234567890">
```

### Setting the user's account plan level

This takes a plan name string, currently the options are 
* basic
* pro
* premier

```ruby 
user = ImageRights::User.new("IB.13395.1234567890")
user.set_account_level("basic")
# => true
```

### Verifying an existing auth token

Auth tokens should not expire, but they can be checked for validity. 

```ruby
user = ImageRights::User.new("IB.13395.1234567890")
user.verify_login
# => true
```

### Generating a one-time login URL

A one-time login url can be retrieved. Users can visit this URL to bypass the login screen. 

```ruby
user = ImageRights::User.new("IB.13395.1234567890")
user.verify_login
# => "https://www.imagerights.com/login_once/IB.13395.1234567890"
```

### Upload Images

Images can be uploaded by providing a path and an optional hash containing the following: 

|      Key    |  Type  | Required | Default      |
|-------------|--------|----------|--------------|
| :mime_type  | String |     N    | "image/jpg"  | 
| :imageset   | String |     N    | "api_upload" |

The method will return an image object with an image_id and the owning user.

```ruby 
path = '/abc/image.jpg'
image_details = { mime_type: 'image/jpg',
                  imageset: 'test set' }

user = ImageRights::User.new("IB.13395.1234567890")
user.upload_image(path, image_details)
# => #<ImageRights::Image:0x007f8586153a20 @image_id="3810422", @user=#<ImageRights::User:0x007f85848ab2c0 @auth_key="IB.13395.1234567890">>
```

### Delete Images

Images can be removed from ImageRights by passing a valid image_id to the the delete_image method. This will return true even if the image does not exist. 

```ruby
user = ImageRights::User.new("IB.13395.1234567890")
user.delete_image("3810422")
# => true
```

## Contributing

* Fork it
* Create your feature branch (git checkout -b my-new-feature)
* Commit your changes (git commit -am 'Add some feature')
* Push to the branch (git push origin my-new-feature)
* Create new Pull Request

The test suit can be run by executing 

```shell
rake test
```






