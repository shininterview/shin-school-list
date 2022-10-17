import UIKit

class TitleDescriptionTableViewCell: UITableViewCell {

  let titleLabel = UILabel()
  let descriptionLabel = UILabel()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setUpSubviews()
  }

  // MARK - Private

  private func setUpSubviews() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.numberOfLines = 0
    descriptionLabel.textColor = UIColor.secondaryLabel

    self.contentView.addSubview(titleLabel)
    self.contentView.addSubview(descriptionLabel)

    let layoutMarginsGuide = self.contentView.layoutMarginsGuide
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),

      descriptionLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      descriptionLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
    ])
  }
}
