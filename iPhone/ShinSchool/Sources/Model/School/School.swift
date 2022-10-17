import Foundation

public class School {
  let borough: String
  let email: String
  let location: String
  let name: String
  let neighborhood: String
  let website: String

  let city: String
  let stateCode: String
  let zip: String

  init(
    borough: String, email: String, location: String, name: String, neighborhood: String,
    website: String, city: String, stateCode: String, zip: String
  ) {
    self.borough = borough
    self.email = email
    self.location = location
    self.name = name
    self.neighborhood = neighborhood
    self.website = website

    self.city = city
    self.stateCode = stateCode
    self.zip = zip
  }
}
