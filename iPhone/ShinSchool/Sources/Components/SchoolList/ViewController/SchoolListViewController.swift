import Foundation
import SafariServices
import UIKit

/// This @c UIViewController shows a list of school.
class SchoolListViewController: UIViewController {
  enum Constants {
    static let pageSize = 10
  }

  private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, School>()
  private var hasMoreData = false
  private var isRequestingData = false
  private let schoolModelRequest: SchoolModelRequest
  private let tableView: UITableView = UITableView()
  private var tableViewDataSource: UITableViewDiffableDataSource<Int, School>

  init(schoolModelRequest: SchoolModelRequest) {
    self.schoolModelRequest = schoolModelRequest

    tableViewDataSource = UITableViewDiffableDataSource<Int, School>(tableView: tableView) {
      tableView, indexPath, school in
      let cellIdentifier = TitleDescriptionTableViewCell.classForCoder().description()
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
      guard let customCell = cell as? TitleDescriptionTableViewCell else {
        assert(false, "Expected a TitleDescriptionTableViewCell.")
        return cell
      }
      customCell.titleLabel.text = school.name
      customCell.descriptionLabel.text = school.neighborhood
      return cell
    }

    super.init(nibName: nil, bundle: nil)
    self.title = NSLocalizedString("School List", comment: "School List")

    dataSourceSnapshot.appendSections([0])
    tableView.dataSource = tableViewDataSource
    tableView.delegate = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    let cellClass: AnyClass = TitleDescriptionTableViewCell.classForCoder()
    tableView.register(cellClass, forCellReuseIdentifier: cellClass.description())
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.systemBackground
    view.addSubview(tableView)

    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
    ])

    fetchSchoolsModel()
  }

  // MARK: - Private

  private func appendAndShowCellsForSchools(_ schools: [School]) {
    // Assume there is more data if the data size is same as the page size.
    hasMoreData = schools.count == Constants.pageSize
    dataSourceSnapshot.appendItems(schools)
    tableViewDataSource.apply(dataSourceSnapshot, animatingDifferences: false)
  }

  private func fetchSchoolsModel() {
    if isRequestingData {
      return
    }

    isRequestingData = true
    schoolModelRequest.fetchSchools(
      pageSize: Constants.pageSize, pageOffset: dataSourceSnapshot.itemIdentifiers.count,
      completion: { [weak self] response in
        do {
          let schools = try response.get()
          if let self = self {
            self.appendAndShowCellsForSchools(schools)
          }
        } catch {
          print(error)
          // TODO: Show error message.
        }

        if let self = self {
          self.isRequestingData = false
        }
      })
  }
}

// MARK: - UITableViewDelegate

extension SchoolListViewController: UITableViewDelegate {

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    guard let navigationController = self.navigationController else {
      assert(false, "Expect to present the SchoolListViewController via a UINavigationController.")
      return
    }

    let schools = dataSourceSnapshot.itemIdentifiers
    let index = indexPath.item
    if index >= schools.count {
      assert(
        false,
        """
        Failed to find the school model for index: \(index). Did you update the data source
        snapshot?
        """
      )
      return
    }

    let school = schools[index]
    let websiteURLString = school.website
    guard let websiteURL = URL(string: websiteURLString) else {
      assert(false, "invalid website: \(school.website)")
      return
    }
    let safariViewController = SFSafariViewController(url: websiteURL)
    navigationController.pushViewController(safariViewController, animated: true)
  }

  func tableView(
    _ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath
  ) {
    if hasMoreData && !isRequestingData
      && indexPath.item == dataSourceSnapshot.itemIdentifiers.count
    {
      fetchSchoolsModel()
    }
  }
}
