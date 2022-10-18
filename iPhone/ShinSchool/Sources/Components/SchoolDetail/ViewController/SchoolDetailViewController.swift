import SafariServices
import UIKit

/// This @c UIViewController shows detail info for a school.
class SchoolDetailViewController: UIViewController {
  private enum Constants {
    static let httpsScheme = "https"
  }

  private let school: School
  private let deps: SchoolDetailViewControllerDeps
  private let totalCountLabel = UILabel()
  private let mathScoreLabel = UILabel()
  private let readingScoreLabel = UILabel()
  private let writingScoreLabel = UILabel()

  init(deps: SchoolDetailViewControllerDeps, school: School) {
    self.deps = deps
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

    stackView.addArrangedSubview(totalCountLabel)
    stackView.addArrangedSubview(mathScoreLabel)
    stackView.addArrangedSubview(readingScoreLabel)
    stackView.addArrangedSubview(writingScoreLabel)

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

    deps.schoolSATScoreRequest.fetchScoresWithScrollID(
      school.UUID,
      completion: { [weak self] response in
        do {
          let score = try response.get()
          if let self = self {
            self.processServerData(score)
          }
        } catch {
          print(error)
          // TODO: Show error message.
        }
      })
  }

  // MARK: - Private

  private func processServerData(_ score: SchoolSATScore) {
    let totalCountText = NSLocalizedString("Total count:", comment: "Total count:")
    let mathScoreText = NSLocalizedString("Math score:", comment: "Math score:")
    let readingScoreText = NSLocalizedString("Reading score:", comment: "Reading score:")
    let writingScoreText = NSLocalizedString("Writing score:", comment: "Writing score:")
    totalCountLabel.text = totalCountText.appending(String(score.count))
    mathScoreLabel.text = mathScoreText.appending(String(score.mathScore))
    readingScoreLabel.text = readingScoreText.appending(String(score.readingScore))
    writingScoreLabel.text = writingScoreText.appending(String(score.writingScore))
  }

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
