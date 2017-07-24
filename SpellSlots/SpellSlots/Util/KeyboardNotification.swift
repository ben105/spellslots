import UIKit

struct KeyboardNotification {

  let notification: Notification
  let userInfo: NSDictionary

  init(_ notification: Notification) {
    self.notification = notification
    if let userInfo = notification.userInfo {
      self.userInfo = userInfo as NSDictionary
    }
    else {
      self.userInfo = NSDictionary()
    }
  }

  var screenFrameBegin: CGRect {
    if let value = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
      return value.cgRectValue
    }
    else {
      return CGRect()
    }
  }

  var screenFrameEnd: CGRect {
    if let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
      return value.cgRectValue
    }
    else {
      return CGRect()
    }
  }

  var animationDuration: Double {
    if let number = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
      return number.doubleValue
    }
    else {
      return 0.25
    }
  }

  var animationCurve: UIViewAnimationCurve {
    if let number = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber {
      return UIViewAnimationCurve(rawValue: number.intValue)!
    }
    return UIViewAnimationCurve.easeInOut
  }

  func frameBeginForView(view: UIView) -> CGRect {
    return view.convert(screenFrameBegin, from: view.window)
  }

  func frameEndForView(view: UIView) -> CGRect {
    return view.convert(screenFrameEnd, from: view.window)
  }
}

extension UIViewAnimationCurve {
  func toOptions() -> UIViewAnimationOptions {
    return UIViewAnimationOptions(rawValue: UInt(rawValue << 16))
  }
}
