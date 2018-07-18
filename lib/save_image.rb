require 'nokogiri'
require 'rest-client'

class SaveImage

	attr_accessor	:url, :parsed_html

	def initialize(url)
		@url = url
		@parsed_html = nil
	end


	def self.save_images(url)
		successfully_saved_img = 0
		
		html   = RestClient.get("#{url}").body
		parsed = Nokogiri::HTML.parse(html)
 
		image_tags = parsed.css("img")
		
		image_tags.each do |img|
		  if img['src'].split('http')[1].nil?
				url  = "http:#{img['src']}"
			else
				url  = "#{img['src']}"	
			end
		  
		  name = url.split("/").last
		 
		  begin
		  	file = RestClient.get(url).body
		  	successfully_saved_img += 1
		  rescue Exception => e
		  	
		  end
		 
		  File.write(name, file, mode: "wb")
		end
		successfully_saved_img
	end

end