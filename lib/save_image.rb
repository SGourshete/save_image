require 'nokogiri'
require 'rest-client'

class SaveImage

	attr_accessor	:url, :parsed_html

	def initialize(link)
		@url = link
		@parsed_html = link.nil?  nil	: parse_html
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


	def snapshot
		h1_tag = get_h1_tags
		p_tag = first_p_tag
		result = h1_tag + p_tag
	end


private

	def parse_html
		html   = RestClient.get("#{url}").body
		Nokogiri::HTML.parse(html)
	end

	def youtube_video_image(size = "sddefault")
		regex = /(https?:\/\/)?(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?[A-Za-z0-9_=-]+&v=)([A-Za-z0-9_-]*)(\&\S+)?(\?\S+)?/
		url.gsub(regex) do
			youtube_video_id = $4
			img = "https://img.youtube.com/vi/#{youtube_video_id}/#{size}.jpg"
		end
		img
	end	

	def get_h1_tags
		@parsed_html.css("h1")
	end

	def first_p_tag
		@parsed_html.css("p").first
	end

end