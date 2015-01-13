require 'net/http'
require 'nokogiri'
require 'open-uri'

# grabs the HTML from the main page of the curiosity rover image gallery
doc = Nokogiri::HTML(open("http://mars.jpl.nasa.gov/msl/multimedia/raw/"))
# collects link suffixes to all pages for each martian solar cycle from each camera
results = doc.css("div.image_list a").map { |link|  link['href']}
base_url = "http://mars.jpl.nasa.gov/msl/multimedia/raw/"
# attaches link suffixes to the base_url
results.map! { |suffix| base_url + suffix }

images = Array.new
def scrape_images
  results.each do |url|
    image_hash = Hash.new
    image_page = Nokogiri::HTML(open(url))
    image_array = image_page.css("div.RawImageCaption div.RawImageUTC a").map { |link| link["href"] }
    image_array.each do |image|
      if !image.to_s.include?("_T")
        image_hash[:img_src] = image
        image_hash[:sol] = url.scan(/(?<==)\d+/).first
        image_hash[:camera] = url.scan(/(?<=camera=)\w+/).first
        images << image_hash
      end
    end
  end
  images
end

