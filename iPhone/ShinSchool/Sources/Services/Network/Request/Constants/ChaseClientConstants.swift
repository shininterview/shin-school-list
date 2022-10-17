import CoreLocation
import Foundation

/// This file contains the client constants for the Chase app. Our unit tests can provide different constants.
class ChaseClientConstants: ClientConstants {
  private enum Constants {
    static let latitudeKey = "latitude"
    static let longitudeKey = "longitude"
    static let defaultLatitude = 40.7128  // New work latitude.
    static let defaultLongitude = -74.0060  // New work longitude.
  }

  var locationCoordinate: CLLocationCoordinate2D {
    var latitude = Constants.defaultLatitude
    var longitude = Constants.defaultLongitude
    let userDefaults = UserDefaults.standard
    if let latitudeNumber = userDefaults.object(forKey: Constants.latitudeKey) as? NSNumber {
      latitude = latitudeNumber.doubleValue
    }
    if let longitudeNumber = userDefaults.object(forKey: Constants.longitudeKey) as? NSNumber {
      longitude = longitudeNumber.doubleValue
    }
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }

  var socrataAppToken: String = "QIJIwfPSzqXgvFAURtmHNpbDw"
}
