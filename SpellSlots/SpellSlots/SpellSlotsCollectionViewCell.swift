import UIKit

class SpellSlotsCollectionViewCell: UICollectionViewCell {

  static let SpellSlotDiameter: CGFloat = 40.0

  private let buttonColor: UIColor = .darkGray

  override var isSelected: Bool {
    didSet {
      self.toggleButton.backgroundColor = isSelected ? self.buttonColor : .white
    }
  }

  private lazy var toggleButton: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.layer.cornerRadius = SpellSlotsCollectionViewCell.SpellSlotDiameter / 2
    button.layer.borderColor = self.buttonColor.cgColor
    button.layer.borderWidth = 1.0
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.isSelected = true
    self.backgroundColor = .clear

    self.addSubview(self.toggleButton)
    self.toggleButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    self.toggleButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    self.toggleButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    self.toggleButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc private func didTapButton(_ sender: UIButton) {
    self.isSelected = !self.isSelected
  }

}
