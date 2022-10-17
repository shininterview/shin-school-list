import Foundation

/// Fake implementation of @c SchoolModelRequest for our unit tests.
class SchoolModelRequestFake: SchoolModelRequest {
  private enum SampleData {
    static let text = "test"
    static let website = "https://www.google.com/"
  }

  func fetchSchools(
    pageSize: Int, pageOffset: Int, completion: @escaping (Result<[School], Error>) -> Void
  ) {
    let school = School(
      borough: SampleData.text,
      email: SampleData.text, location: SampleData.text, name: SampleData.text,
      neighborhood: SampleData.text, website: SampleData.website, city: SampleData.text,
      stateCode: SampleData.text,
      zip: SampleData.text)
    completion(.success([school]))
  }
}
