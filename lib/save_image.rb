require 'nokogiri'
require 'rest-client'

class SaveImage

	attr_accessor	:url, :parsed_html

	def initialize(link)
		@url = link
		@parsed_html = nil	
	end


	def self.save_images(url)
		successfully_saved_img = 0
		
		#{url}").body
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


private

	def parse_html
		html   = RestClient.get("#{url}").body
		@parsed_html = Nokogiri::HTML.parse(html)
	end

	def get_h1_tags
		@parsed_html.css("h1")
	end

	def first_p_tag
		@parsed_html.css("p").first
	end

end