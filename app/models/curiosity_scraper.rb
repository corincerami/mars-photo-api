class CuriosityScraper
  require "open-uri"
  require 'json'
  BASE_URL = "https://mars.nasa.gov/api/v1/raw_image_items/"

  attr_reader :rover
  def initialize
    @rover = Rover.find_by(name: "Curiosity")
  end

  def scrape
    create_photos
  end

  def collect_links
    # Fetch the latest sol available through the API
    response = JSON.parse(URI.open(BASE_URL + "?order=sol%20desc,instrument_sort%20asc,sample_type_sort%20asc,%20date_taken%20desc&per_page=1&page=0&condition_1=msl:mission").read)
    latest_sol_available = response["items"].first["sol"].to_i
    latest_sol_scraped = rover.photos.maximum(:sol).to_i
    sols_to_scrape = (latest_sol_scraped..latest_sol_available).to_a.last(10) # Only fetch the last 10 sols

    sols_to_scrape.map { |sol|
      "#{BASE_URL}?order=sol%20desc,instrument_sort%20asc,sample_type_sort%20asc,%20date_taken%20desc&per_page=200&page=0&condition_1=msl:mission&condition_2=#{sol}:sol:in"
    }
  end

  private

  def create_photos
    collect_links.each do |url|
      scrape_photo_page(url)
    end
  end

  def scrape_photo_page(url)
    begin
      response = JSON.parse(URI.open(url).read)
      response['items'].each do |image|
        create_photo(image) if image['extended'] && image['extended']['sample_type'] == 'full'
      end
    rescue OpenURI::HTTPError => e
      puts "HTTP error occurred: #{e.message} for URL: #{url}. Skipping."
    rescue StandardError => e
      puts "Error occurred: #{e.message} for URL: #{url}. Skipping."
    end
  end

  def create_photo(image)
    sol = image['sol']
    camera = camera_from_json(image)
    link = image['https_url']
    
    if camera.is_a?(String)
      puts "WARNING: Camera not found. Name: #{camera}"
    else
      photo = Photo.find_or_initialize_by(sol: sol, camera: camera, img_src: link, rover: rover)
      photo.log_and_save_if_new
    end
  end

  def camera_from_json(image)
    camera_name = image['instrument']
    rover.cameras.find_by(name: camera_name) || camera_name
  end
end
