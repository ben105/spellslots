import UIKit

class PlusSign: UIView {

  var barWidth: CGFloat = 4.0

  fileprivate var horizontalView: UIView
  fileprivate var verticalView: UIView

  var color: UIColor {
    get {
      return horizontalView.backgroundColor!
    }
    set(newColor) {
      horizontalView.backgroundColor = newColor
      verticalView.backgroundColor = newColor
    }
  }

  convenience init() {
    self.init(frame: CGRect())
  }

  override init(frame: CGRect) {
    self.horizontalView = UIView()
    self.horizontalView.translatesAutoresizingMaskIntoConstraints = false
    self.horizontalView.backgroundColor = UIColor.white

    self.verticalView = UIView()
    self.verticalView.translatesAutoresizingMaskIntoConstraints = false
    self.verticalView.backgroundColor = UIColor.white

    super.init(frame: frame)

    self.addSubview(self.horizontalView)
    self.horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    self.horizontalView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    self.horizontalView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    self.addSubview(self.verticalView)
    self.verticalView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    self.verticalView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    self.verticalView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    horizontalView.heightAnchor.constraint(equalToConstant: barWidth).isActive = true
    verticalView.widthAnchor.constraint(equalToConstant: barWidth).isActive = true
  }

}
