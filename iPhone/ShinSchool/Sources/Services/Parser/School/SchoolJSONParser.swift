import Foundation

/// Helper class for parsing the school data from the API response.
/// See a sample response below to see the available properties:
/// https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$$app_token=QIJIwfPSzqXgvFAURtmHNpbDw&$limit=1
public class SchoolJSONParser {
  public static func schoolsFromJSONArray(_ JSONArray: [[String: AnyObject]]) -> [School] {
    var schools = [School]()
    for dictionary in JSONArray {
      if let school = self.schoolFromDictionary(dictionary) {
        schools.append(school)
      } else {
        assert(false, "Failed to parse school JSON.")
      }
    }
    return schools
  }

  public static func schoolFromDictionary(_ dictionary: [String: AnyObject]) -> School? {
    var email = ""
    if let emailText = dictionary[SchoolTableColumn.email] as? String {
      email = emailText
    }
    guard let location = dictionary[SchoolTableColumn.location] as? String else {
      return nil
    }
    guard let name = dictionary[SchoolTableColumn.name] as? String else {
      return nil
    }
    guard let neighborhood = dictionary[SchoolTableColumn.neighborhood] as? String else {
      return nil
    }
    guard let website = dictionary[SchoolTableColumn.website] as? String else {
      return nil
    }
    guard let UUID = dictionary[SchoolTableColumn.databaseNumber] as? String else {
      return nil
    }
    guard let city = dictionary[SchoolTableColumn.city] as? String else {
      return nil
    }
    guard let zip = dictionary[SchoolTableColumn.zip] as? String else {
      return nil
    }
    guard let stateCode = dictionary[SchoolTableColumn.stateCode] as? String else {
      return nil
    }
    guard let borough = dictionary[SchoolTableColumn.borough] as? String else {
      return nil
    }
    return School(
      borough: borough, email: email, location: location, name: name, neighborhood: neighborhood,
      website: website, UUID: UUID, city: city, stateCode: stateCode, zip: zip)
  }
}
