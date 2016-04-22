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

```ruby
gem install image_rights
```

You will need to have a Partner Key provided to you by ImageRights. This is used to authenticate every request. 

You must initialize the library with this. 

```ruby 
ImageRights.configure do |c|
  c.partner_key = ENV["IMAGERIGHTS_TEST_KEY"]
end
```
## Usage

All functions are accessible through the ImageRights::User class. 

### Setting up a new user

This takes a hash containing, email and first and last name. 

```ruby 
ImageRights::User.create_account({email: 'test@example.com', first_name: 'Harry', last_name: 'Curotta'})
# => #<ImageRights::User:0x007ff224ac8c08 @auth_key="IB.13395.1234567890">
```

### Verifying an existing auth token

Auth tokens should not expire, but they can be checked for validity. 

```ruby
user = ImageRights::User.new("IB.13395.1234567890")
user.verify_login
# => true
```
