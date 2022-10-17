import CoreLocation

/// We create a protocol for ChaseClientConstnats so our unit test can easily create a fake implementation of this protocol.
protocol ClientConstants {
  var locationCoordinate: CLLocationCoordinate2D { get }
  var socrataAppToken: String { get }
}
