import Foundation

/// The server API parameters.
/// See the available parameters: https://dev.socrata.com/docs/queries/
struct RequestParameterConstants {
  static let appTokenKey = "$$app_token"
  static let limitKey = "$limit"
  static let offsetKey = "$offset"
  static let whereKey = "$where"
}
