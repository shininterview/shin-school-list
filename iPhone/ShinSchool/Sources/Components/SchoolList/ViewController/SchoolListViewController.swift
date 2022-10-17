import Foundation
import UIKit

/// This @c UIViewController shows a list of school.
class SchoolListViewController : UIViewController {
  enum Constants {
    static let pageSize = 1
  }
  private let schoolModelRequest: SchoolModelRequest
  private let tableView: UITableView = UITableView()
  private let isRequestingData = false

  init(schoolModelRequest: SchoolModelRequest) {
    self.schoolModelRequest = schoolModelRequest
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    tableView.translatesAutoresizingMaskIntoConstraints = false
    let cellClass: AnyClass = UITableViewCell.classForCoder()
    tableView.register(cellClass, forCellReuseIdentifier: cellClass.description())
    let dataSource = UITableViewDiffableDataSource<Int, School>(tableView: tableView) { tableView, indexPath, school in
      let cellIdentifier = UITableViewCell.classForCoder().description()
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
      cell.textLabel?.text = school.name
      cell.detailTextLabel?.text = school.neighborhood
      return cell
    }
    tableView.dataSource = dataSource

    var dataSourceSnapshot = dataSource.snapshot()
    dataSourceSnapshot.appendSections([0])
    
    view.addSubview(tableView)

    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
    ])

    schoolModelRequest.fetchSchools(pageSize: Constants.pageSize, pageOffset: 0, completion: { [weak self] response in
      do {
        let schools = try response.get()
        if let self = self {
          dataSourceSnapshot.appendItems(schools)
          self.appendAndShowCellsForSchools(schools)
        }
      } catch {
        print(error)
        // TODO: Show error message.
      }
    })
  }

  private func appendAndShowCellsForSchools(_ schools: [School]) {
    
  }
}
