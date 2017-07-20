import UIKit

class SpellSlotTableViewCell: UITableViewCell {

  fileprivate static let Inset: CGFloat = 16.0
  fileprivate static let LabelWidth: CGFloat = 130.0
  static let CellHeight: CGFloat = 100.0

  fileprivate static let CollectionCellIdentifier: String = "CollectionCell"

  fileprivate var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
    cv.register(
      SpellSlotsCollectionViewCell.self,
      forCellWithReuseIdentifier: CollectionCellIdentifier)
    cv.backgroundColor = UIColor.clear
    cv.translatesAutoresizingMaskIntoConstraints = false
    return cv
  }()

  /// This label is used instead of the superclass `textLabel` due to the fact that when the cell is
  /// selected, and then deselected, the label is recreated. This removes any anchors or layout
  /// constraints that may have been there before.
  var rowLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  /// This represents how many slots can possibly be filled.
  fileprivate let numberOfSlots: UInt

  /// This represents how many slots have been filled (left to right).
  var slotsComplete: UInt = 0

  init(numberOfSlots: UInt, reuseIdentifier: String?) {
    self.numberOfSlots = numberOfSlots
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    // Hide the text label that would be displayed otherwise.
    self.textLabel?.isHidden = false

    // And show the row label instead of the text label.
    self.addSubview(self.rowLabel)
    self.rowLabel.leftAnchor.constraint(
      equalTo: self.leftAnchor,
      constant: SpellSlotTableViewCell.Inset).isActive = true
    self.rowLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.rowLabel.widthAnchor.constraint(
      equalToConstant: SpellSlotTableViewCell.LabelWidth).isActive = true

    self.collectionView.delegate = self
    self.collectionView.dataSource = self

    self.addSubview(self.collectionView)
    self.collectionView.leftAnchor.constraint(
      equalTo: self.rowLabel.rightAnchor,
      constant: SpellSlotTableViewCell.Inset).isActive = true
    self.collectionView.rightAnchor.constraint(
      equalTo: self.rightAnchor,
      constant: -SpellSlotTableViewCell.Inset).isActive = true
    self.collectionView.topAnchor.constraint(
      equalTo: self.topAnchor,
      constant: SpellSlotTableViewCell.Inset).isActive = true
    self.collectionView.bottomAnchor.constraint(
      equalTo: self.bottomAnchor,
      constant: -SpellSlotTableViewCell.Inset).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SpellSlotTableViewCell: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int
  {
    return Int(numberOfSlots)
  }


  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: SpellSlotTableViewCell.CollectionCellIdentifier,
      for: indexPath)
    // TODO: Configure the cell
    return cell
  }

}

extension SpellSlotTableViewCell : UICollectionViewDelegateFlowLayout {

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize
  {
    return CGSize(
      width: SpellSlotsCollectionViewCell.SpellSlotDiameter,
      height: SpellSlotsCollectionViewCell.SpellSlotDiameter)
  }

}
