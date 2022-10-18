import Foundation

/// Helper used for fetching school informations.
class NewYorkSchoolModelRequest: SchoolModelRequest {

  private enum APIConstants {
    static let radiusDistance = 0.02
    static let schoolAPIEndPoint = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
  }

  let clientConstants: ClientConstants

  init(clientConstants: ClientConstants) {
    self.clientConstants = clientConstants
  }

  func fetchSchools(
    pageSize: Int, pageOffset: Int, completion: @escaping (Result<[School], Error>) -> Void
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
        return
      }

      guard let data = data else {
        completion(.failure(ClientError.invalidServerResponse))
        return
      }

      let JSONObject = try? JSONSerialization.jsonObject(with: data, options: [])
      guard let JSONArray = JSONObject as? [[String: AnyObject]] else {
        completion(.failure(ClientError.invalidServerResponse))
        return
      }

      let schools = SchoolJSONParser.schoolsFromJSONArray(JSONArray)
      completion(.success(schools))
    }

    dataTask.resume()
  }
}
