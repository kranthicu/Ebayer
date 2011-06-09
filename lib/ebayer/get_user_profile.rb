class Ebay

  attr_accessor :open_url, :callname, :response_encoding, :app_id, :user_id, :response


  def initialize(open_url, callname, response_encoding, api_version,  app_id, user_id)
    @open_url = open_url
    @callname = callname
    @response_encoding= response_encoding
    @api_version = api_version
    @app_id = app_id
    @user_id = user_id
  end
  


  def url_definer
    url = @open_url+"?callname=#{@callname}&responseencoding=#{@response_encoding}&appid=#{@app_id}&siteid=0&UserID=#{@user_id}&IncludeSelector=Details&version=#{@api_version}"
    return url
  end

  def request_ebay
    requested_url = self.url_definer
    new_response = HTTParty.get(requested_url)
    @response = self.response_parser(new_response.body)
  end
  
  def response_parser(response_content)
    Hashie::Mash.new(JSON(response_content))
  end

  def success?
    self.response_content ? (self.response_content["Ack"] == "Success") : (self.response_content["Ack"] == "Failure")
  end
  
  def user_information
    self.request_ebay
  end


end
