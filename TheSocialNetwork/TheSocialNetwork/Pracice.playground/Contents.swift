//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    var isTurnOver = false
    var imageHeart: UIImageView!
    var imageHeartFill: UIImageView!
    
    lazy var someValue: Int = test()
    
    func test() -> Int {
        Int.random(in: 0...10)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .gray

//        let label = UILabel()
//        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
//        label.text = "Hello World!"
//        label.textColor = .black
//
//        view.addSubview(label)
        
        self.view = view
        setupView(view)
    }
    
    func setupView(_ mainView: UIView) {
        
//        let view = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
//        view.backgroundColor = .clear
        
        let button = UIButton(frame: CGRect(x: 50, y: 10, width: 25, height: 25))
        
        button.addTarget(self, action: #selector(pressButton(_:)), for: .touchUpInside)
        
        
        imageHeart = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageHeartFill = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        
        imageHeart.image = UIImage(systemName: "heart")
        imageHeart.tintColor = .blue
        
        imageHeartFill.image = UIImage(systemName: "heart.fill")
        imageHeartFill.tintColor = .systemPink
        //imageHeartFill.alpha = 0
        
        //button.addSubview(imageHeartFill)
        button.addSubview(imageHeart)
        
        
        
        
        //viewHeart
        //button.backgroundColor = .red
        //button
        
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        imageView.image = UIImage(systemName: "heart")
        //button.tintColor = .blue
//        button.setImage(UIImage(systemName: "heart"), for: .normal)
        
        //mainView.addSubview(button)
        mainView.addSubview(button)
        
//        view.layer.cornerRadius = 25
//
//        let path = UIBezierPath()
//        path.move(to: .zero)
//        path.addLine(to: CGPoint(x: 25, y: 25))
//
//        let layer = CAShapeLayer()
//        layer.lineWidth = 3
//        layer.strokeColor = UIColor.black.cgColor
//        layer.path = path.cgPath
//
//        view.layer.addSublayer(layer)
//        view.layer.masksToBounds = true
//
//
//        mainView.addSubview(view)
    }
    
    @objc func pressButton(_ sender: UIButton) {
        //print("1")
        isTurnOver.toggle()
        
        if isTurnOver {
            //imageHeart.alpha = 0
            //imageHeartFill.alpha = 1
            UIView.transition(from: imageHeart, to: imageHeartFill, duration: 0.5, options: .transitionFlipFromLeft, completion: nil)
        } else {
            //imageHeart.alpha = 1
            //imageHeartFill.alpha = 0
            UIView.transition(from: imageHeartFill, to: imageHeart, duration: 0.5, options: .transitionFlipFromRight, completion: nil)
        }
        
        print("\(someValue)")

        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
