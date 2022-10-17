import Foundation
import UIKit

/// This @c UIViewController shows a list of school.
class SchoolListViewController: UIViewController {
  enum Constants {
    static let pageSize = 10
  }

  private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, School>()
  private var isRequestingData = false
  private let schoolModelRequest: SchoolModelRequest
  private let tableView: UITableView = UITableView()
  private var tableViewDataSource: UITableViewDiffableDataSource<Int, School>

  init(schoolModelRequest: SchoolModelRequest) {
    self.schoolModelRequest = schoolModelRequest

    tableViewDataSource = UITableViewDiffableDataSource<Int, School>(tableView: tableView) {
      tableView, indexPath, school in
      let cellIdentifier = UITableViewCell.classForCoder().description()
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
      cell.textLabel?.text = school.name
      return cell
    }

    super.init(nibName: nil, bundle: nil)

    dataSourceSnapshot.appendSections([0])
    tableView.dataSource = tableViewDataSource
    tableView.translatesAutoresizingMaskIntoConstraints = false
    let cellClass: AnyClass = UITableViewCell.classForCoder()
    tableView.register(cellClass, forCellReuseIdentifier: cellClass.description())
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

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
    dataSourceSnapshot.appendItems(schools)
    tableViewDataSource.apply(dataSourceSnapshot, animatingDifferences: false)
  }

  private func fetchSchoolsModel() {
    if isRequestingData {
      return
    }

    isRequestingData = true
    schoolModelRequest.fetchSchools(
      pageSize: Constants.pageSize, pageOffset: 0,
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
