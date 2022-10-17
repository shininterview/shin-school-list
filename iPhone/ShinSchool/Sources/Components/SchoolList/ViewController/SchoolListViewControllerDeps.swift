import Foundation

/// Dependencies for @c SchoolListViewController.
class SchoolListViewControllerDeps {
  let schoolModelRequest: SchoolModelRequest

  init(schoolModelRequest: SchoolModelRequest) {
    self.schoolModelRequest = schoolModelRequest
  }
}
