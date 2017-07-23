import UIKit

class SpellSlotsTableViewCell: UITableViewCell {

  static let CellReuseIdentifier: String = "SpellSlotsTableCellIdentifier"

  static let CellHeight: CGFloat = 100.0

  fileprivate let collectionViewModel: CollectionViewModel

  var editMode: Bool = false {
    didSet {
      collectionView.reloadData()
      collectionViewModel.editMode = editMode
    }
  }

  fileprivate var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
    cv.register(
      SpellSlotsCollectionViewCell.self,
      forCellWithReuseIdentifier: CollectionViewModel.CollectionCellIdentifier)
    cv.backgroundColor = UIColor.clear
    cv.translatesAutoresizingMaskIntoConstraints = false
    return cv
  }()

  fileprivate static let Inset: CGFloat = 16.0
  fileprivate static let LabelWidth: CGFloat = 130.0

  /// This label is used instead of the superclass `textLabel` due to the fact that when the cell is
  /// selected, and then deselected, the label is recreated. This removes any anchors or layout
  /// constraints that may have been there before.
  var rowLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  init(numberOfSlots: UInt, reuseIdentifier: String?) {
    self.collectionViewModel = CollectionViewModel(numberOfSlots: numberOfSlots)
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    // Hide the text label that would be displayed otherwise.
    self.textLabel?.isHidden = false

    // And show the row label instead of the text label.
    self.addSubview(self.rowLabel)
    self.rowLabel.leftAnchor.constraint(
      equalTo: self.leftAnchor,
      constant: SpellSlotsTableViewCell.Inset).isActive = true
    self.rowLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.rowLabel.widthAnchor.constraint(
      equalToConstant: SpellSlotsTableViewCell.LabelWidth).isActive = true

    self.collectionView.delegate = self.collectionViewModel
    self.collectionView.dataSource = self.collectionViewModel

    self.addSubview(self.collectionView)
    self.collectionView.leftAnchor.constraint(
      equalTo: self.rowLabel.rightAnchor,
      constant: SpellSlotsTableViewCell.Inset).isActive = true
    self.collectionView.rightAnchor.constraint(
      equalTo: self.rightAnchor,
      constant: -SpellSlotsTableViewCell.Inset).isActive = true
    self.collectionView.topAnchor.constraint(
      equalTo: self.topAnchor,
      constant: SpellSlotsTableViewCell.Inset).isActive = true
    self.collectionView.bottomAnchor.constraint(
      equalTo: self.bottomAnchor,
      constant: -SpellSlotsTableViewCell.Inset).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
