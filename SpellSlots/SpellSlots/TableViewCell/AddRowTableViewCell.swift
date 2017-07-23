import UIKit

protocol AddRowTableViewCellDelegate: class {
  func didTouchAddRow()
}

class AddRowTableViewCell: UITableViewCell {

  static let CellReuseIdentifier: String = "AddRowTableCellIdentifier"

  static let CellHeight: CGFloat = 50.0
  fileprivate static let Inset: CGFloat = 10.0
  fileprivate static let LargeInset: CGFloat = 34.0

  weak var delegate: AddRowTableViewCellDelegate?

  init(delegate: AddRowTableViewCellDelegate?, reuseIdentifier: String?) {
    self.delegate = delegate
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    let plusRow = PlusRowView()
    plusRow.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(plusRow)
    plusRow.leftAnchor.constraint(
      equalTo: self.contentView.leftAnchor,
      constant: AddRowTableViewCell.LargeInset).isActive = true
    plusRow.topAnchor.constraint(
      equalTo: self.contentView.topAnchor,
      constant: AddRowTableViewCell.Inset).isActive = true
    plusRow.bottomAnchor.constraint(
      equalTo: self.contentView.bottomAnchor,
      constant: -AddRowTableViewCell.Inset).isActive = true
    plusRow.widthAnchor.constraint(equalToConstant: 120.0)

    plusRow.addTarget(self, action: #selector(shouldAddRow(sender:)), for: .touchUpInside)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc fileprivate func shouldAddRow(sender: AnyObject) {
    delegate?.didTouchAddRow()
  }
}
