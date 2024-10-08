class CuriosityScraper
  require "open-uri"
  require 'json'
  BASE_URL = "https://mars.nasa.gov/msl/multimedia/raw/"

  attr_reader :rover
  def initialize
    @rover = Rover.find_by(name: "Curiosity")
  end

  def scrape
    create_photos
  end

  # grabs the HTML from the main page of the curiosity rover image gallery
  def main_page
    Nokogiri::HTML(URI.open("https://mars.nasa.gov/msl/multimedia/raw-images/?order=sol+desc%2Cinstrument_sort+asc%2Csample_type_sort+asc%2C+date_taken+desc&per_page=50&page=0&mission=msl"))
  end

	def collect_links
	  latest_sol_available = JSON.parse(main_page.css('[data-react-props]').last.attr('data-react-props'))["header_counts"]["latest_sol"].to_i
	  latest_sol_scraped = rover.photos.maximum(:sol).to_i
	  sols_to_scrape = (latest_sol_scraped..latest_sol_available).to_a.last(10) # Limit to the last 50 sols
	  sols_to_scrape.map { |sol| "https://mars.nasa.gov/api/v1/raw_image_items/?order=sol%20desc,instrument_sort%20asc,sample_type_sort%20asc,%20date_taken%20desc&per_page=200&page=0&condition_1=msl:mission&condition_2=2024-10-07T17:30:51.000Z:date_received:gte&condition_3=#{sol}:sol:in&search=&extended=thumbnail::sample_type::noteq" }

	end

  private

	def create_photos
	  collect_links.each do |url|
		puts "Starting to scrape photos for URL: #{url}"
		scrape_photo_page(url)
		puts "Finished scraping photos for URL: #{url}"
	  end
	end

def scrape_photo_page(url)
  begin
    Timeout.timeout(30) do  # Set a 30-second timeout for each page request
      image_page = Nokogiri::HTML(URI.open(url, open_timeout: 10, read_timeout: 20))
      image_array = image_page.css("div.RawImageCaption a").map { |link| link["href"] }

      puts "Found #{image_array.count} photos for URL: #{url}"

      image_array.each do |image|
        create_photo(image, url)
      end
    end
  rescue Timeout::Error
    puts "Timeout occurred when scraping URL: #{url}. Moving on to the next one."
  rescue OpenURI::HTTPError => e
    puts "HTTP error occurred: #{e.message} for URL: #{url}. Moving on to the next one."
  rescue StandardError => e
    puts "An error occurred: #{e.message} for URL: #{url}. Moving on to the next one."
  end
end

  def create_photo(image, url)
    if !thumbnail?(image)
      sol = url.scan(/(?<==)\d+/).first
      camera = camera_from_url image
      fail "Camera not found. Name: #{camera}" if camera.is_a?(String)
      photo = Photo.find_or_initialize_by(sol: sol, camera: camera,
                                          img_src: image, rover: rover)
      photo.log_and_save_if_new
    end
  end

  def camera_abbreviations
    {
      fcam: "FHAZ",
      rcam: "RHAZ",
      ccam: "CHEMCAM",
      mcam: "MAST",
      ncam: "NAVCAM",
      mhli: "MAHLI",
      mrdi: "MARDI"
    }
  end

  def thumbnail?(image_url)
    image_url.to_s.include?("_T")
  end

  def camera_from_url(image_url)
    camera_abbreviation = image_url.match(/\/(?<camera>\w{4})\/\w+.(JPG|jpg|PNG|png)/)[:camera]
    camera_name = camera_abbreviations[camera_abbreviation.to_sym]
    rover.cameras.find_by(name: camera_name) || camera_name || camera_abbreviation
  end
end
