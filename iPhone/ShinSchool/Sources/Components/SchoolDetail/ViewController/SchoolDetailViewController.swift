import SafariServices
import UIKit

/// This @c UIViewController shows detail info for a school.
class SchoolDetailViewController: UIViewController {
  private enum Constants {
    static let httpsScheme = "https"
  }

  private let school: School

  init(school: School) {
    self.school = school
    super.init(nibName: nil, bundle: nil)

    self.title = school.name
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground

    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(scrollView)

    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    scrollView.addSubview(stackView)

    let addressLabel = UILabel()
    addressLabel.text = "\(school.location) \(school.city) \(school.stateCode) \(school.zip)"
    stackView.addArrangedSubview(addressLabel)

    let neighborhoodLabel = UILabel()
    neighborhoodLabel.text = school.neighborhood
    stackView.addArrangedSubview(neighborhoodLabel)

    let websiteButton = UIButton()
    websiteButton.backgroundColor = .systemTeal
    let websiteText = NSLocalizedString("Website", comment: "Website")
    websiteButton.addTarget(self, action: #selector(presentWebViewController), for: .touchUpInside)
    websiteButton.setTitle(websiteText, for: .normal)
    stackView.addArrangedSubview(websiteButton)

    let layoutMarginsGuide = self.view.layoutMarginsGuide
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
    ])
  }

  // MARK: - Private

  @objc private func presentWebViewController() {
    guard let navigationController = self.navigationController else {
      assert(false, "Expect to present the SchoolListViewController via a UINavigationController.")
      return
    }

    let websiteURLString = school.website
    guard var URLComponents = URLComponents(string: websiteURLString) else {
      assert(false, "invalid website: \(websiteURLString)")
      return
    }
    if URLComponents.scheme == nil {
      URLComponents.scheme = Constants.httpsScheme
    }

    guard let websiteURL = URLComponents.url else {
      assert(false, "invalid website: \(websiteURLString)")
      return
    }
    let safariViewController = SFSafariViewController(url: websiteURL)
    navigationController.pushViewController(safariViewController, animated: true)
  }
}
