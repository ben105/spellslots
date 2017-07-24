import UIKit

extension SpellSlotsViewController: SpellSlotsCellDelegate {

  func headsUpSpellSlotsCell(cell: SpellSlotsTableViewCell,
    animationDuration duration: Double,
    animationCurve curve: UIViewAnimationCurve,
    yDistance: CGFloat)
  {
    UIView.animate(
      withDuration: duration,
      delay: 0,
      options: curve.toOptions(),
      animations: {
        self.view.frame.size.height = (yDistance + 26)
        guard let indexPath = self.tableView.indexPath(for: cell) else {
          return
        }
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
      },
      completion: nil)
  }

  func headsDown(animationDuration duration: Double, animationCurve curve: UIViewAnimationCurve) {
    UIView.animate(
      withDuration: duration,
      delay: 0,
      options: curve.toOptions(),
      animations: {
        self.view.frame.origin.y = 0
        self.view.frame.size.height = UIScreen.main.bounds.size.height
      },
      completion: nil)
  }

  func spellSlotsCell(cell: SpellSlotsTableViewCell, didChangeTitle toTitle: String) {
    guard let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    rowData[indexPath.row] = toTitle
  }
  
}
