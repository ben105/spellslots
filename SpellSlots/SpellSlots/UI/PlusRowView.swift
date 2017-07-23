import UIKit

class PlusRowView: UIControl {

  private static let Inset: CGFloat = 6.0

  convenience init() {
    self.init(frame: CGRect())
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.backgroundColor = Colors.spellSlotRed
    self.layer.cornerRadius = PlusRowView.Inset

    let plusSign = PlusSign()
    plusSign.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(plusSign)
    plusSign.leftAnchor.constraint(
      equalTo: self.leftAnchor,
      constant: PlusRowView.Inset).isActive = true
    plusSign.topAnchor.constraint(
      equalTo: self.topAnchor,
      constant: PlusRowView.Inset).isActive = true
    plusSign.bottomAnchor.constraint(
      equalTo: self.bottomAnchor,
      constant: -PlusRowView.Inset).isActive = true
    plusSign.widthAnchor.constraint(equalTo: plusSign.heightAnchor).isActive = true

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "ADD ROW"
    label.textColor = UIColor.white
    label.font = UIFont.systemFont(ofSize: 10.0)
    self.addSubview(label)
    label.leftAnchor.constraint(
      equalTo: plusSign.rightAnchor,
      constant: PlusRowView.Inset).isActive = true
    label.rightAnchor.constraint(
      equalTo: self.rightAnchor,
      constant: -PlusRowView.Inset).isActive = true
    label.topAnchor.constraint(equalTo: self.topAnchor, constant: PlusRowView.Inset).isActive = true
    label.bottomAnchor.constraint(
      equalTo: self.bottomAnchor,
      constant: -PlusRowView.Inset).isActive = true
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
