//
//  ViewController.swift
//  SpellSlots
//
//  Created by Ben Rooke on 7/18/17.
//  Copyright © 2017 Ben Rooke. All rights reserved.
//

import UIKit

class SpellSlotsViewController: UIViewController {

  var editMode: Bool = false // TODO: Toggle with edit button

  // TODO: Update the row data (String value is just for testing).
  var rowData: [String] = ["Row 1", "Row 2", "Row 3"]

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
  }

}

extension SpellSlotsViewController: UITableViewDelegate {

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return TableViewCell.CellHeight
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
  }

}

extension SpellSlotsViewController: UITableViewDataSource {

  fileprivate func tableView(
    _ tableView: UITableView,
    slotsForIndexPath indexPath: IndexPath) -> TableViewCell
  {
    var cell: TableViewCell? = tableView.dequeueReusableCell(
      withIdentifier: TableViewCell.CellReuseIdentifier) as? TableViewCell

    if (cell == nil) {
      cell = TableViewCell(
        numberOfSlots: 4, // TODO: Pull the number of slots from the row data.
        reuseIdentifier: TableViewCell.CellReuseIdentifier)
    }

    cell!.textLabel!.text = rowData[indexPath.row]
    return cell!
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rowData.count
  }

  public func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    var cell: UITableViewCell!
    if indexPath.row == rowData.count - 1 && editMode {
      // If we are loading the last row and we are in edit mode, show the 'ADD ROW' row.
      // TODO: Instantiate an edit row.
      cell = UITableViewCell()
    } else {
      cell = self.tableView(tableView, slotsForIndexPath: indexPath)
    }
    return cell
  }
}
