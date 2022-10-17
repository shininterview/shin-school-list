import Foundation

/// Helper used for fetching school informations.
class NewYorkSchoolJSONRequest {

  enum APIConstants {
    static let radiusDistance = 0.1
    static let schoolAPIEndPoint = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
  }

  let clientConstants: ClientConstants

  init(clientConstants: ClientConstants) {
    self.clientConstants = clientConstants
  }

  func fetchJSONObjects(
    pageSize: Int, pageOffset: Int,
    completion: @escaping (Result<[Any], Error>) -> Void
  ) {
    guard var requestURLComponents = URLComponents(string: APIConstants.schoolAPIEndPoint) else {
      assert(false, "The API end point is incorrect.")
      return
    }

    // A sample url can be:  https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$$app_token=QIJIwfPSzqXgvFAURtmHNpbDw&$limit=20&$offset=20&$where=latitude between 40.6128 and 40.8128 and longitude between -74.106 and -73.906
    let appTokenQueryItem = URLQueryItem(
      name: RequestParameterConstants.appTokenKey, value: clientConstants.socrataAppToken)

    let limitQueryItem = URLQueryItem(
      name: RequestParameterConstants.limitKey, value: String(pageSize))

    let offsetQueryItem = URLQueryItem(
      name: RequestParameterConstants.offsetKey, value: String(pageOffset))

    let locationCoordinate = clientConstants.locationCoordinate
    // A sample whereQuery can be: where=latitude between 40.6128 and 40.8128 and longitude between -74.106 and -73.906
    let whereQuery =
      "\(SchoolTableColumn.latitude) between \(locationCoordinate.latitude - APIConstants.radiusDistance) and \(locationCoordinate.latitude + APIConstants.radiusDistance) and \(SchoolTableColumn.longitude) between \(locationCoordinate.longitude - APIConstants.radiusDistance) and \(locationCoordinate.longitude + APIConstants.radiusDistance)"

    let whereQueryItem = URLQueryItem(name: RequestParameterConstants.whereKey, value: whereQuery)

    requestURLComponents.queryItems = [
      appTokenQueryItem, limitQueryItem, offsetQueryItem, whereQueryItem,
    ]

    guard let requestURL = requestURLComponents.url else {
      assert(false, "Failed to fetch school JSON data. Is the URL malformed?")
      return
    }

    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        if let JSONString = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
          completion(.success(JSONString))
        } else {
          completion(.failure(ClientError.invalidServerResponse))
        }
      }
    }

    dataTask.resume()
  }
}
