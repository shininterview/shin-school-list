import Foundation

class NewYorkSchoolModelRequest: SchoolModelRequest {
  let schoolJSONRequest: NewYorkSchoolJSONRequest

  init(clientConstants: ClientConstants) {
    self.schoolJSONRequest = NewYorkSchoolJSONRequest(clientConstants: clientConstants)
  }

  func fetchSchools(
    pageSize: Int, pageOffset: Int, completion: @escaping (Result<[School], Error>) -> Void
  ) {
    schoolJSONRequest.fetchJSONObjects(pageSize: pageSize, pageOffset: pageOffset) { response in
      do {
        let objectArray = try response.get()
        guard let JSONArray = objectArray as? [[String: AnyObject]] else {
          completion(.failure(ClientError.invalidServerResponse))
          return
        }
        let schools = SchoolJSONParser.schoolsFromJSONArray(JSONArray)
        completion(.success(schools))
      } catch {
        completion(.failure(error))
      }
    }
  }
}
