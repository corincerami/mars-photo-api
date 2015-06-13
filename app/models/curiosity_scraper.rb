class CuriosityScraper
  BASE_URL = "http://mars.jpl.nasa.gov/msl/multimedia/raw/"
  ROVER = Rover.find_by(name: "Curiosity")

  def scrape
    create_photos
  end

  # grabs the HTML from the main page of the curiosity rover image gallery
  def main_page
    Nokogiri::HTML(open("http://mars.jpl.nasa.gov/msl/multimedia/raw/"))
  end

  def collect_links
    # collects link suffixes to all pages for each martian solar cycle from each camera
    main_page.css("div.image_list a").map { |link|  link['href'] }
  end

  def create_photos
    collect_links.each do |url|
      image_page = Nokogiri::HTML(open(BASE_URL + url))
      image_array = image_page.css("div.RawImageCaption div.RawImageUTC a").map { |link| link["href"] }
      image_array.each do |image|
        if !image.to_s.include?("_T")
          sol = url.scan(/(?<==)\d+/).first
          camera = url.scan(/(?<=camera=)\w+/).first
          p = Photo.find_or_create_by(sol: sol, camera: camera, img_src: image, rover: ROVER)
          Rails.logger.info "Photo with id #{p.id} created from #{p.rover.name}"
          Rails.logger.info "img_src: #{p.img_src}, sol: #{p.sol}, camera: #{p.camera}"
        end
      end
    end
  end
end
