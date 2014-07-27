require "net/http"

PublishJob.class_eval do

  def post_process_with_konopas
    # do the original job
    post_process_without_konopas

    begin
      # get the Konopas config
      config = PlannerKonopas::KonopasConfig.first
      
      if config
        # Prime the cache
        if !config.base_url.blank?
          make_request(config.base_url + '/konopas/program.js')
          make_request(config.base_url + '/konopas/program/participants.js')
        end
        
        # and now reset the Konopas manifest
        make_request(config.manfest_url,  config.manfest_user,  config.manfest_password) if !config.manfest_url.blank?
        make_request(config.calendar_url, config.calendar_user, config.calendar_password) if !config.calendar_url.blank?
        # uri = URI.parse('https://konopas-server.appspot.com/loncon3/update_prog') <div style="padding:10px; padding-top: 0px; padding-bottom: 0px;">
        # uri = URI.parse('http://guide.loncon3.org/util/update-cache-manifest.php')
      end
    rescue => ex
      # so we do not force a repulish if there is an issue
      # TODO - log to say what happened
    end
  end

  alias_method_chain :post_process, :konopas

  protected

  def make_request(uri_str, username = nil, password = nil)
    uri = URI.parse(uri_str)
    if uri.scheme == "https"
      Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new uri
        response = http.request request
      end
    else  
      req = Net::HTTP::Get.new(uri)
      req.basic_auth username, password if !username.blank? && !password.blank?
      res = Net::HTTP.start(uri.hostname, uri.port) {|http|
        http.request(req)
      }
    end
  end

end
