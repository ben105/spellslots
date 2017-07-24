import UIKit

/// The collection view model keeps the collection view logic from the table view cell. This logic
/// could be interchangable in the future.
class CollectionViewModel:
  NSObject,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout
{

  static let CollectionCellIdentifier: String = "CollectionCellIdentifier"

  /// This represents how many slots can possibly be filled.
  fileprivate var numberOfSlots: UInt

  /// This represents the index of the furthest most completed slot.
  fileprivate var slotCompleteIndex: Int = 0

  var editMode: Bool = false {
    didSet {
      if !editMode && slotCompleteIndex == Int(numberOfSlots) {
        slotCompleteIndex -= 1
      }
    }
  }

  init(numberOfSlots: UInt) {
    self.numberOfSlots = numberOfSlots
    super.init()
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int
  {
    var numberOfItems = Int(numberOfSlots)
    if editMode {
      numberOfItems += 1
    }
    return numberOfItems
  }


  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CollectionViewModel.CollectionCellIdentifier,
      for: indexPath) as! SpellSlotsCollectionViewCell

    if indexPath.row > slotCompleteIndex {
      cell.deselect()
    } else {
      cell.select()
    }

    cell.isPlusCell = indexPath.row == Int(numberOfSlots)

    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize
  {
    return CGSize(
      width: SpellSlotsCollectionViewCell.SpellSlotDiameter,
      height: SpellSlotsCollectionViewCell.SpellSlotDiameter)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)

    // Touching the cell at this index path row means the user is touching the plus button.
    if indexPath.row == Int(numberOfSlots) {
      numberOfSlots += 1
      collectionView.reloadData()
      return
    }

    // Touching on a plain cell while in edit mode will shrink the row back down to that point.
    if editMode {
      numberOfSlots = UInt(indexPath.row)
      if slotCompleteIndex >= indexPath.row {
        slotCompleteIndex = indexPath.row - 1
      }
      collectionView.reloadData()
      return
    }

    // Normal behavior of touching a cell.
    if indexPath.row == slotCompleteIndex {
      slotCompleteIndex = indexPath.row - 1
    } else {
      slotCompleteIndex = indexPath.row
    }
    collectionView.reloadData()
  }
}
