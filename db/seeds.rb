require 'net/http'
require 'nokogiri'
require 'open-uri'

# grabs the HTML from the main page of the curiosity rover image gallery
doc = Nokogiri::HTML(open("http://mars.jpl.nasa.gov/msl/multimedia/raw/"))
# collects link suffixes to all pages for each martian solar cycle from each camera
@results = doc.css("div.image_list a").map { |link|  link['href']}
base_url = "http://mars.jpl.nasa.gov/msl/multimedia/raw/"
# attaches link suffixes to the base_url
@results.map! { |suffix| base_url + suffix }

def scrape_images
  @results.each do |url|
    image_page = Nokogiri::HTML(open(url))
    image_array = image_page.css("div.RawImageCaption div.RawImageUTC a").map { |link| link["href"] }
    image_array.each do |image|
      if !image.to_s.include?("_T")
        sol = url.scan(/(?<==)\d+/).first
        camera = url.scan(/(?<=camera=)\w+/).first
        p = Photo.find_or_create_by(sol: sol, camera: camera, img_src: image)
        Rails.logger.info "Photo with id #{p.id} created, img_src: #{p.img_src}, sol: #{p.sol}, camera: #{p.camera}"
      end
    end
  end
end

scrape_images
