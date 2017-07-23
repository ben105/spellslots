import UIKit

class SpellSlotsCollectionViewCell: UICollectionViewCell {

  static let SpellSlotDiameter: CGFloat = 40.0
  fileprivate static let Inset: CGFloat = 10.0

  fileprivate var plusSign: PlusSign = PlusSign()
  var isPlusCell: Bool = false {
    didSet {
      updateView()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 1.0
    self.layer.cornerRadius = SpellSlotsCollectionViewCell.SpellSlotDiameter / 2.0

    self.contentView.addSubview(self.plusSign)
    self.plusSign.translatesAutoresizingMaskIntoConstraints = false
    self.plusSign.color = Colors.spellSlotRed
    self.plusSign.leftAnchor.constraint(
      equalTo: self.contentView.leftAnchor,
      constant: SpellSlotsCollectionViewCell.Inset).isActive = true
    self.plusSign.topAnchor.constraint(
      equalTo: self.contentView.topAnchor,
      constant: SpellSlotsCollectionViewCell.Inset).isActive = true
    self.plusSign.bottomAnchor.constraint(
      equalTo: self.contentView.bottomAnchor,
      constant: -SpellSlotsCollectionViewCell.Inset).isActive = true
    self.plusSign.rightAnchor.constraint(
      equalTo: self.contentView.rightAnchor,
      constant: -SpellSlotsCollectionViewCell.Inset).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  fileprivate func updateView() {
    plusSign.isHidden = !isPlusCell
    if isPlusCell {
      deselect()
    }
  }

  func select() {
    self.backgroundColor = Colors.spellSlotRed
  }

  func deselect() {
    self.backgroundColor = .white
  }

}
