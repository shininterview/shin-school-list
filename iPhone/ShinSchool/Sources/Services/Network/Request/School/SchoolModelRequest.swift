import Foundation

/// Class used for fetching school informations.
protocol SchoolModelRequest {
  func fetchSchools(
    pageSize: Int, pageOffset: Int,
    completion: @escaping (Result<[School], Error>) -> Void)
}
