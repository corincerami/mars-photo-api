[![Version](https://img.shields.io/badge/version-1.1.2-brightgreen.svg)](http://github.com/chrisccerami/mars-photo-api)[![Build Status](https://travis-ci.org/chrisccerami/mars-photo-api.svg)](https://travis-ci.org/chrisccerami/mars-photo-api)[![Code Climate](https://codeclimate.com/github/chrisccerami/mars-photo-api/badges/gpa.svg)](https://codeclimate.com/github/chrisccerami/mars-photo-api)[![Test Coverage](https://codeclimate.com/github/chrisccerami/mars-photo-api/badges/coverage.svg)](https://codeclimate.com/github/chrisccerami/mars-photo-api/coverage)

# Mars Rover Photo API

This API is designed to collect image data gathered by NASA's Curiosity, Opportunity, and Spirit rovers on Mars and make it more easily available to other developers, educators, and citizen scientists.

## API Keys

You do not need to authenticate in order to explore rate-limited (30 requests per IP address per hour / 50 requests per IP address per day) NASA data at https://api.nasa.gov/mars-photos/ if you include `api_key=DEMO_KEY`. However, if you will be intensively using the APIs to, say, support a mobile application, then you should sign up for a [NASA developer key](https://api.nasa.gov/index.html#apply-for-an-api-key). You can include this API key in a request with a query parameter `api_key=<YOUR_KEY>`.

## Photo Attributes

Each rover has its own set of photos stored in the database, which can be queried separately. There are several possible queries that can be made against the API. Photos are organized by the sol (Martian rotation or day) on which they were taken, counting up from the rover's landing date. A photo taken on Curiosity's 1000th Martian sol exploring Mars, for example, will have a sol attribute of 1000. If instead you prefer to search by the Earth date on which a photo was taken, you can do that too.

Along with querying by date, results can also be filtered by the camera with which it was taken. Each camera has a unique function and perspective, and they are named as follows:

### Cameras

  Abbreviation | Camera                         | Curiosity | Opportunity | Spirit
  ------------ | ------------------------------ | --------  | ----------- | ------ |
   FHAZ|Front Hazard Avoidance Camera|✔|✔|✔|
   RHAZ|Rear Hazard Avoidance Camera|✔|✔|✔|
   MAST|Mast Camera| ✔||
   CHEMCAM|Chemistry and Camera Complex  |✔||
   MAHLI|Mars Hand Lens Imager|✔||
   MARDI|Mars Descent Imager|✔||
   NAVCAM|Navigation Camera|✔|✔|✔|
   PANCAM|Panoramic Camera| |✔|✔|
   MINITES|Miniature Thermal Emission Spectrometer (Mini-TES)| |✔|✔|

## Querying the API

Substitute `https://api.nasa.gov/mars-photos/` with `https://mars-photos.herokuapp.com/` if you want to query the API from a web application. The heroku version allows cross-origin requests and *doesnt require an API key*.

The API can be queried in the following format:

### Photo Endpoint

#### Queries by Martian sol:

Queries by sol can range from 0, which is the date of landing, up to the current maximum in the database. The current max sol for each rover can be found at that rover's endpoint.

https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY

#### Querying by Earth date:

Dates should be formatted as 'yyyy-mm-dd'. The earliest date available is the date of landing for each rover.

https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=DEMO_KEY

#### Filtering Queries by Camera:

The camera parameter is not case sensitive, but must be one of the camera abbreviations listed in the table above for the respective rover.

https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=DEMO_KEY

https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?earth_date=2015-6-3&camera=pancam&api_key=DEMO_KEY

#### Query For Latest Photos

If you just want to receive photo data for the most recent Sol for which photos exist for a particular rover, you can visit the `/latest_photos` endpoint.

https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/latest_photos&api_key=DEMO_KEY

### Mission Manifest Endpoint

A mission manifest is available for each Rover at the `/manifests/<rover_name>`. This manifest will list details of the Rover's mission to help narrow down photo queries to the API. The information in the manifest includes:

- name
- landing_date
- launch_date
- status
- max_sol
- max_date
- total_photos

It also includes a list of objects under the `photos` key which are grouped by `sol`, and each of which contains:

- sol
- total_photos
- cameras

An example entry from `/manifests/Curiosity` might look like:

```
{
  sol: 0,
  earth_date: "2012-08-06"
  total_photos: 3702,
  cameras: [
    "CHEMCAM",
    "FHAZ",
    "MARDI",
    "RHAZ"
  ]
}
```

This would tell you that this rover, on sol 0, took 3702 photos, and those are from among the CHEMCAM, FHAZ, MARDI, and RHAZ cameras.

The database will be updated regularly with the latest photos from the red planet.

## Contributing

If you would like to contribute to Mars Rover Photo API, feel free to create a pull request. If you'd like to contact me, you can reach me at chrisccerami@gmail.com or on Twitter [@chrisccerami](https://twitter.com/chrisccerami).

1. Fork it ( https://github.com/chrisccerami/mars-photos-api/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
