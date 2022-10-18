import Foundation

enum ClientError: Error {
  /// Indicates there is either invalid server data or unexpected server data.
  case invalidServerResponse
}
