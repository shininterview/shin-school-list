import Foundation

/// Dependencies for @c SchoolListViewController.
protocol SchoolListViewControllerDeps: SchoolDetailViewControllerDeps {
  var schoolModelRequest: SchoolModelRequest { get }
}
