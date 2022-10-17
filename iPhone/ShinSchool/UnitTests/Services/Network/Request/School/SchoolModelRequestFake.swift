import Foundation

/// Fake implementation of @c SchoolModelRequest.
class SchoolModelRequestFake: SchoolModelRequest {
  enum Constants {
    static let sampleText = "test"
  }

  func fetchSchools(
    pageSize: Int, pageOffset: Int, completion: @escaping (Result<[School], Error>) -> Void
  ) {
    let school = School(
      borough: Constants.sampleText,
      email: Constants.sampleText, location: Constants.sampleText, name: Constants.sampleText,
      neighborhood: Constants.sampleText, website: Constants.sampleText, city: Constants.sampleText,
      stateCode: Constants.sampleText,
      zip: Constants.sampleText)
    completion(.success([school]))
  }
}
