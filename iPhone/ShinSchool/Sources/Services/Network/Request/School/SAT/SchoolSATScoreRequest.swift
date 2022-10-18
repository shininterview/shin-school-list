import Foundation

/// Class used for fetching school SAT scores.
/// Our unit tests can create a fake @c SchoolSATScoreRequest implementation to test against fake
/// school SAT scores.
protocol SchoolSATScoreRequest {
  func fetchScoresWithScrollID(
    _ schoolID: String,
    completion: @escaping (Result<SchoolSATScore, Error>) -> Void)
}
