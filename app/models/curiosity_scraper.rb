class CuriosityScraper
  require "open-uri"
  require 'json'
  BASE_URL = "https://mars.jpl.nasa.gov/msl/multimedia/raw/"

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
    sols_to_scrape = latest_sol_scraped..latest_sol_available
    sols_to_scrape.map { |sol|
      "https://mars.nasa.gov/msl/raw/listimagesraw.cfm?&s=#{sol}"
    }
  end

  private

  def create_photos
    collect_links.each do |url|
      scrape_photo_page(url)
    end
  end

  def scrape_photo_page(url)
    image_page = Nokogiri::HTML(URI.open url)
    image_array = image_page.css("div.RawImageCaption a")
      .map { |link| link["href"] }
    image_array.each do |image|
      create_photo(image, url)
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
