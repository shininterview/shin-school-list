/// The SQL table column names for the school data.
/// See a sample response below:
/// https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$$app_token=QIJIwfPSzqXgvFAURtmHNpbDw&$limit=1
enum SchoolTableColumn {
  static let email = "school_email"
  static let location = "location"
  static let name = "school_name"
  static let neighborhood = "neighborhood"
  static let website = "website"

  static let city = "city"
  static let zip = "zip"
  static let stateCode = "state_code"
  static let borough = "borough"

  static let latitude = "latitude"
  static let longitude = "longitude"
}
