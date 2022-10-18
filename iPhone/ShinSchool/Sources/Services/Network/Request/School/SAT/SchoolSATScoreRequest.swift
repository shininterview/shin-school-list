import Foundation

/// Class used for fetching school SAT scores.
/// Our unit tests can create a fake @c SchoolModelRequest implementation to test against fake school SAT scores.
protocol SchoolSATScoreRequest {
  func fetchSchools(
    schoolID: String,
    completion: @escaping (Result<SchoolSATScore, Error>) -> Void)
}
