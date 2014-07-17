require "net/http"

PublishJob.class_eval do

  def perform_with_konopas
    
    # do the original job
    perform_without_konopas
    
    # and now reset the Konopas manifest
    uri = URI('http://guide.loncon3.org/util/update-cache-manifest.php')
    req = Net::HTTP::Get.new(uri)
    req.basic_auth 'ko', 'kokko'
    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }
    
    #
    uri = URI.parse('https://konopas-server.appspot.com/loncon3/update_prog')
    Net::HTTP.start(uri.host, uri.port,
          :use_ssl => uri.scheme == 'https') do |http|
            request = Net::HTTP::Get.new uri
            response = http.request request
          end
    
  end

  alias_method_chain :perform, :konopas

end
