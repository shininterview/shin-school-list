import Foundation

/// Class used for fetching school informations.
/// Our unit tests can create a fake @c SchoolModelRequest implementation to test against fake school models.
protocol SchoolModelRequest {
  func fetchSchools(
    pageSize: Int, pageOffset: Int,
    completion: @escaping (Result<[School], Error>) -> Void)
}
