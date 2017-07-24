import Foundation

typealias RowDataType = [ String : [ String: AnyObject ]]

let rowNameKey: String = "rowName"
let completedKey: String = "completedSlots"
let totalKey: String = "totalSlots"

class RowEntry {

  var totalSlots: UInt
  var completedSlots: UInt

  var title: String = "Empty"

  init(completed: UInt, total: UInt) {
    self.totalSlots = total
    self.completedSlots = completed
  }

}

func createRowEntries(forRowData data: RowDataType) -> [RowEntry] {
  var rows: [RowEntry] = []

  let sortedKeys = Array(data.keys).sorted(by: <)
  for key in sortedKeys {
    guard let rowDetails = data[key] else {
      continue
    }
    let completed: UInt = rowDetails[completedKey] as? UInt ?? 0
    let total: UInt = rowDetails[totalKey] as? UInt ?? 0
    let rowEntry = RowEntry(completed: completed, total: total)
    rowEntry.title = rowDetails[rowNameKey] as? String ?? ""
    rows.append(rowEntry)
  }

  return rows
}

func createRowData(forRowEntries entries: [RowEntry]) -> RowDataType {
  var data: RowDataType = [:]

  for (index, row) in entries.enumerated() {
    data[String(index)] = [
      completedKey: NSNumber(value: row.completedSlots) as AnyObject,
      totalKey: NSNumber(value: row.totalSlots) as AnyObject,
      rowNameKey: row.title as AnyObject
    ]
  }

  return data
}
