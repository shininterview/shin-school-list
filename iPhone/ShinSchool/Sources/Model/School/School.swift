import Foundation

/// Model for the school object.
/// See a sample response below to see the available properties:
/// https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$$app_token=QIJIwfPSzqXgvFAURtmHNpbDw&$limit=1
public class School {
  let borough: String
  let email: String
  let location: String
  let name: String
  let neighborhood: String
  let website: String
  let UUID: String

  let city: String
  let stateCode: String
  let zip: String

  init(
    borough: String, email: String, location: String, name: String, neighborhood: String,
    website: String, UUID: String, city: String, stateCode: String, zip: String
  ) {
    self.borough = borough
    self.email = email
    self.location = location
    self.name = name
    self.neighborhood = neighborhood
    self.website = website
    self.UUID = UUID

    self.city = city
    self.stateCode = stateCode
    self.zip = zip
  }

  public static func == (lhs: School, rhs: School) -> Bool {
    return
      lhs.borough == rhs.borough && lhs.email == rhs.email && lhs.location == rhs.location
      && lhs.name == rhs.name && lhs.neighborhood == rhs.neighborhood && lhs.website == rhs.website
      && lhs.UUID == rhs.UUID && lhs.city == rhs.city && lhs.stateCode == rhs.stateCode
      && lhs.zip == rhs.zip
  }
}

// MARK: - Hashable

extension School: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(name)
    hasher.combine(website)
    hasher.combine(UUID)
  }
}
