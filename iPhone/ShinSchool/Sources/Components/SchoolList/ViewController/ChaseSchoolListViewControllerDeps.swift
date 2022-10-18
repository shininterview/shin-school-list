import Foundation

/// Dependencies for @c SchoolListViewController.
class ChaseSchoolListViewControllerDeps: SchoolListViewControllerDeps {
  var schoolSATScoreRequest: SchoolSATScoreRequest

  var schoolModelRequest: SchoolModelRequest

  init(schoolModelRequest: SchoolModelRequest, schoolSATScoreRequest: SchoolSATScoreRequest) {
    self.schoolModelRequest = schoolModelRequest
    self.schoolSATScoreRequest = schoolSATScoreRequest
  }
}
