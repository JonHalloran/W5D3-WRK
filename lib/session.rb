require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  attr_accessor :session

  def initialize(req)
    @req = req
    cookies = req.cookies
    our_cookies = cookies["_rails_lite_app"]
    # p our_cookies
    self.session =  JSON.parse(our_cookies) if our_cookies
    self.session ||= {}
  end

  def [](key)
    self.session[key]
  end

  def []=(key, val)
    self.session[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    @res = res
    @res.set_cookie('_rails_lite_app', {path: "/", value: session.to_json})
    @res
  end
end
