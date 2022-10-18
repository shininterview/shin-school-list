import Foundation

/// Helper used for fetching school informations.
class NewWorkSchoolSATScoreRequest: SchoolSATScoreRequest {

  private enum APIConstants {
    static let schoolAPIEndPoint = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
  }

  let clientConstants: ClientConstants

  init(clientConstants: ClientConstants) {
    self.clientConstants = clientConstants
  }

  func fetchScoresWithScrollID(
    _ schoolID: String,
    completion: @escaping (Result<SchoolSATScore, Error>) -> Void
  ) {
    guard var requestURLComponents = URLComponents(string: APIConstants.schoolAPIEndPoint) else {
      assert(false, "The API end point is incorrect.")
      return
    }

    // A sample url can be:
    // https://data.cityofnewyork.us/resource/f9bf-2cp4.json?$$app_token=QIJIwfPSzqXgvFAURtmHNpbDw&$where=dbn='01M450'
    let appTokenQueryItem = URLQueryItem(
      name: RequestParameterConstants.appTokenKey, value: clientConstants.socrataAppToken)

    // A sample whereQuery can be: where=dbn='01M450'.
    let whereQuery = "\(SchoolTableColumn.databaseNumber)='\(schoolID)'"
    let whereQueryItem = URLQueryItem(name: RequestParameterConstants.whereKey, value: whereQuery)

    requestURLComponents.queryItems = [appTokenQueryItem, whereQueryItem]

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
      guard let JSONArray = JSONObject as? [Any] else {
        completion(.failure(ClientError.invalidServerResponse))
        return
      }

      guard let dictionary = JSONArray.first as? [String: AnyObject] else {
        completion(.failure(ClientError.invalidServerResponse))
        return
      }

      if let score = SchoolSATJSONScoreParser.schoolSATScoreFromDictionary(dictionary) {
        completion(.success(score))
      } else {
        completion(.failure(ClientError.invalidServerResponse))
      }
    }

    dataTask.resume()
  }
}
