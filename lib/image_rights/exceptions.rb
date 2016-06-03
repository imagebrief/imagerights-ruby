# Define Exceptions

module ImageRights
  class ImageRights::BadRequest < Exception; end  
  class ImageRights::InvalidPartnerKey < Exception; end
  class ImageRights::InvalidAuthKey < Exception; end
  class ImageRights::UnprocessableRequest < Exception; end
  class ImageRights::InvalidFilenameGiven < Exception; end
  class ImageRights::RateLimitExceeded < Exception; end
  # class ImageRights::InvalidPlanLevel; end
end