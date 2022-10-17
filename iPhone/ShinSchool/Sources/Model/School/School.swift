import Foundation

public class School {
  let email: String
  let location: String
  let name: String
  let neighborhood: String
  let website: String

  let city: String
  let zip: String
  let stateCode: String
  let borough: String

  init(
    email: String, location: String, name: String, neighborhood: String,
    website: String, city: String, zip: String, stateCode: String, borough: String
  ) {
    self.email = email
    self.location = location
    self.name = name
    self.neighborhood = neighborhood
    self.website = website

    self.city = city
    self.zip = zip
    self.stateCode = stateCode
    self.borough = borough
  }
}
