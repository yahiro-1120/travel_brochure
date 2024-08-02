Geocoder.configure(
  lookup: :google,
  #use_https: true,
  api_key: Rails.application.credentials.geocoding_api_key,
  units: :km
)
