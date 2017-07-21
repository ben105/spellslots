import UIKit

class PlusSign: UIView {

  var barWidth: CGFloat = 4.0

  fileprivate let horizontalView: UIView
  fileprivate let verticalView: UIView

  convenience init() {
    self.init(frame: CGRect())
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.horizontalView = UIView()
    self.horizontalView.backgroundColor = UIColor.white
    self.addSubview(self.horizontalView)

    self.verticalView = UIView()
    self.verticalView.backgroundColor = UIColor.white
    self.addSubview(self.verticalView)

    self.horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    self.horizontalView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    self.horizontalView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

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
