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
  fileprivate let numberOfSlots: UInt

  /// This represents how many slots have been filled (left to right).
  fileprivate var slotsComplete: UInt = 0

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
    return Int(numberOfSlots)
  }


  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CollectionViewModel.CollectionCellIdentifier,
      for: indexPath)
    // TODO: Configure the cell
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

}
