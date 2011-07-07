module Ebayer
    
  class OpenEbay
    EBAYOPENURL= "http://open.api.sandbox.ebay.com/shopping"
    RESPONSEENCODING = "JSON"
    APIVERSION = "721"
  
    attr_accessor :open_url, :callname, :response_encoding, :app_id, :user_id, :response

    def initialize( callname, app_id, user_id)
      @callname = callname
      @app_id = app_id
      @user_id = user_id
    end

    ##Defineing the url. URL should have all the required elements like following:
    ##callname - Name of the method being called    
    ##ResponseEncoding - Response format. XML, JSON, Text formats are allowed. For this version lets keep JSON
    ##AppId  - Appid is generated on ebay. While in production ensure you are using production keys and not sandbox
    ##ApiVersion - Version of api you are placing the call.

    def url_definer
      url = EBAYOPENURL+"?callname=#{@callname}&responseencoding=#{RESPONSEENCODING}&appid=#{@app_id}&siteid=0&UserID=#{@user_id}&IncludeSelector=Details&version=#{APIVERSION}"
      return url
    end

    ##Placing request to ebay via httparty.
   
    def request_ebay
      requested_url = self.url_definer
      response = nil 
      begin
      new_response = HTTParty.get(requested_url)
      rescue Timeout::Error
        raise TimeoutError, "Ebay is currently unavailbale. Please try again later"
      end
      @response = self.response_parser(new_response.body)
    end

    ##response parsing from string to JSON and mashing it into hash format of access. The rails way!    
    def response_parser(response_content)
      Hashie::Mash.new(JSON(response_content))
    end
      
    ##For all those who require just the information and do no require whole response. Just a handy method.
    def user_information
      self.request_ebay
    end
  end

  class EbayError < StandardError; end
  class TimeoutError < EbayError; end

end

