//
//  ViewController.swift
//  SpellSlots
//
//  Created by Ben Rooke on 7/18/17.
//  Copyright © 2017 Ben Rooke. All rights reserved.
//

import UIKit

class SpellSlotsViewController: UIViewController {

  var editMode: Bool = false {
    didSet {
      isEditing = editMode
      tableView.reloadData()
    }
  }

  var rowEntries: [RowEntry] = []

  var tableView: UITableView = {
    let tv = UITableView()
    tv.allowsSelection = false
    tv.translatesAutoresizingMaskIntoConstraints = false
    return tv
  }()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Spell Slots"
    view.addSubview(tableView)

    // Add the edit button to the top nav bar.
    editButtonItem.action = #selector(toggleEditMode(sender:))
    editButtonItem.tintColor = UIColor.white
    navigationItem.rightBarButtonItem = editButtonItem
  }

  @objc fileprivate func toggleEditMode(sender: AnyObject) {
    editMode = !editMode
  }

}

extension SpellSlotsViewController: AddRowTableViewCellDelegate {
  public func didTouchAddRow() {
    rowEntries.append(RowEntry(completed: 0, total: 0))
    tableView.reloadData()
  }
}

extension SpellSlotsViewController: UITableViewDelegate {

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == rowEntries.count {
      return AddRowTableViewCell.CellHeight
    }
    return SpellSlotsTableViewCell.CellHeight
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
  }

}

extension SpellSlotsViewController: UITableViewDataSource {

  fileprivate func tableView(
    _ tableView: UITableView,
    slotsForIndexPath indexPath: IndexPath) -> SpellSlotsTableViewCell
  {
    var cell: SpellSlotsTableViewCell? = tableView.dequeueReusableCell(
      withIdentifier: SpellSlotsTableViewCell.CellReuseIdentifier) as? SpellSlotsTableViewCell

    if (cell == nil) {
      cell = SpellSlotsTableViewCell(
        numberOfSlots: 4, // TODO: Pull the number of slots from the row data.
        reuseIdentifier: SpellSlotsTableViewCell.CellReuseIdentifier)
    }

    cell!.editMode = editMode
    cell!.rowLabel.text = rowEntries[indexPath.row].title
    cell!.delegate = self
    return cell!
  }

  fileprivate func addRowCell(forTableView tableView: UITableView) -> AddRowTableViewCell {
    var cell: AddRowTableViewCell? = tableView.dequeueReusableCell(
      withIdentifier: AddRowTableViewCell.CellReuseIdentifier) as? AddRowTableViewCell

    if (cell == nil) {
      cell = AddRowTableViewCell(
        delegate: self,
        reuseIdentifier: AddRowTableViewCell.CellReuseIdentifier)
    }

    return cell!
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var numberOfRows = rowEntries.count
    if editMode {
      numberOfRows += 1
    }
    return numberOfRows
  }

  public func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    var cell: UITableViewCell!
    if indexPath.row == rowEntries.count {
      // If we are loading the last row and we are in edit mode, show the 'ADD ROW' row.
      cell = addRowCell(forTableView: tableView)
    } else {
      cell = self.tableView(tableView, slotsForIndexPath: indexPath)
    }
    return cell
  }
}
