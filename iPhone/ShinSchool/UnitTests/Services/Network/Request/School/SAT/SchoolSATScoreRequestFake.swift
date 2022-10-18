import Foundation

/// Fake implementation of @c SchoolSATScoreRequest for our unit tests.
class SchoolSATScoreRequestFake: SchoolSATScoreRequest {
  private enum SampleData {
    static let number = 400
  }

  func fetchScoresWithScrollID(
    _ schoolID: String,
    completion: @escaping (Result<SchoolSATScore?, Error>) -> Void
  ) {
    let score = SchoolSATScore(
      count: SampleData.number, mathScore: SampleData.number, readingScore: SampleData.number,
      writingScore: SampleData.number)
    completion(.success(score))
  }
}
