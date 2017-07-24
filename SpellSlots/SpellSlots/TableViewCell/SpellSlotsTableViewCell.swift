import UIKit

protocol SpellSlotsCellDelegate: class {
  func headsUpSpellSlotsCell(cell: SpellSlotsTableViewCell,
    animationDuration duration: Double,
    animationCurve curve: UIViewAnimationCurve,
    yDistance: CGFloat)
  func headsDown(animationDuration duration: Double, animationCurve curve: UIViewAnimationCurve)
  func spellSlotsCell(cell: SpellSlotsTableViewCell, didChangeTitle toTitle: String)
  func spellSlotsCell(cell: SpellSlotsTableViewCell, changedTotalSlots toSlots: UInt)
  func spellSlotsCell(cell: SpellSlotsTableViewCell, changedCompletedSlots toSlots: UInt)
}

class SpellSlotsTableViewCell: UITableViewCell {

  static let CellReuseIdentifier: String = "SpellSlotsTableCellIdentifier"

  static let CellHeight: CGFloat = 60.0

  fileprivate let collectionViewModel: CollectionViewModel
  var completedSlots: UInt {
    get {
      return UInt(collectionViewModel.slotCompleteIndex + 1)
    }
    set(newValue) {
      collectionViewModel.slotCompleteIndex = Int(newValue) - 1
    }
  }

  weak var delegate: SpellSlotsCellDelegate?

  var editMode: Bool = false {
    didSet {
      collectionView.reloadData()
      collectionViewModel.editMode = editMode

      // Some UI changes for the editMode state:
      editTitleControl.isHidden = !editMode
      editTitleControl.isEnabled = editMode
      if !editMode { disableTitleEdit() }
    }
  }

  fileprivate var editTitleControl: UIControl = {
    let control = UIControl()
    control.isHidden = true
    control.isEnabled = false
    control.translatesAutoresizingMaskIntoConstraints = false
    return control
  }()

  fileprivate var rowTextField: UITextField = {
    let textField = UITextField()
    textField.isHidden = true
    textField.returnKeyType = .done
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()

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
  fileprivate static let LabelWidth: CGFloat = 140.0

  /// This label is used instead of the superclass `textLabel` due to the fact that when the cell is
  /// selected, and then deselected, the label is recreated. This removes any anchors or layout
  /// constraints that may have been there before.
  var rowLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12.0)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  init(numberOfSlots: UInt, reuseIdentifier: String?) {
    self.collectionViewModel = CollectionViewModel(numberOfSlots: numberOfSlots)
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    self.collectionViewModel.delegate = self

    // Hide the text label that would be displayed otherwise.
    self.textLabel?.isHidden = true

    // And show the row label instead of the text label.
    self.addSubview(self.rowLabel)
    self.rowLabel.leftAnchor.constraint(
      equalTo: self.leftAnchor,
      constant: SpellSlotsTableViewCell.Inset).isActive = true
    self.rowLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.rowLabel.widthAnchor.constraint(
      equalToConstant: SpellSlotsTableViewCell.LabelWidth).isActive = true

    // Add the text field (invisible at first).
    self.addSubview(self.rowTextField)
    self.rowTextField.addTarget(self, action: #selector(disableTitleEdit), for: .editingDidEnd)
    self.rowTextField.leftAnchor.constraint(equalTo: self.rowLabel.leftAnchor).isActive = true
    self.rowTextField.rightAnchor.constraint(equalTo: self.rowLabel.rightAnchor).isActive = true
    self.rowTextField.topAnchor.constraint(equalTo: self.rowLabel.topAnchor).isActive = true
    self.rowTextField.bottomAnchor.constraint(
      equalTo: self.rowLabel.bottomAnchor).isActive = true

    // Add the edit title control above the row label (but it is hidden by default).
    self.editTitleControl.addTarget(self, action: #selector(enableTitleEdit), for: .touchUpInside)
    self.addSubview(self.editTitleControl)
    self.editTitleControl.leftAnchor.constraint(equalTo: self.rowLabel.leftAnchor).isActive = true
    self.editTitleControl.rightAnchor.constraint(equalTo: self.rowLabel.rightAnchor).isActive = true
    self.editTitleControl.topAnchor.constraint(equalTo: self.rowLabel.topAnchor).isActive = true
    self.editTitleControl.bottomAnchor.constraint(
      equalTo: self.rowLabel.bottomAnchor).isActive = true

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

    // Disable edit when the keyboard is dismissed (e.g. another title is selected).
    NotificationCenter.default.addObserver(
      forName: .UITextFieldTextDidEndEditing,
      object: self.rowTextField,
      queue: OperationQueue.main) {
        (_) in
        self.disableTitleEdit()
      }

    NotificationCenter.default.addObserver(
      forName: .UIKeyboardWillShow,
      object: nil,
      queue: OperationQueue.main) {
        (notification) in
        let info = KeyboardNotification(notification)
        self.delegate?.headsUpSpellSlotsCell(
          cell: self,
          animationDuration: info.animationDuration,
          animationCurve: info.animationCurve,
          yDistance: info.screenFrameEnd.size.height)
      }

    NotificationCenter.default.addObserver(
      forName: .UIKeyboardWillHide,
      object: nil,
      queue: OperationQueue.main) {
        (notification) in
        let info = KeyboardNotification(notification)
        self.delegate?.headsDown(
          animationDuration: info.animationDuration,
          animationCurve: info.animationCurve)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

// This extension enables the user to edit the row title.
extension SpellSlotsTableViewCell {

  @objc fileprivate func enableTitleEdit() {
    rowLabel.isHidden = true
    editTitleControl.isHidden = true

    rowTextField.text = rowLabel.text
    rowTextField.isHidden = false
    rowTextField.becomeFirstResponder()
  }

  @objc fileprivate func disableTitleEdit() {
    rowLabel.text = rowTextField.text
    delegate?.spellSlotsCell(cell: self, didChangeTitle: rowLabel.text!)

    rowLabel.isHidden = false
    editTitleControl.isHidden = false

    rowTextField.isHidden = true
    rowTextField.resignFirstResponder()
  }

}

extension SpellSlotsTableViewCell: CollectionViewModelDelegate {

  func didChangeTotalSlots(toSlots: UInt) {
    delegate?.spellSlotsCell(cell: self, changedTotalSlots: toSlots)
  }

  func didChangeCompletedSlots(toSlots: UInt) {
    delegate?.spellSlotsCell(cell: self, changedCompletedSlots: toSlots)
  }

}
