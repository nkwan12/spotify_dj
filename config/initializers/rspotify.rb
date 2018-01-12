module RSpotify
  class User
    # Returns the current user
    def self.me
      path = "me"

      response = RSpotify.get path
      return response if RSpotify.raw_response
      new response unless response.nil?
    end
  end
end