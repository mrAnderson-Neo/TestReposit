//
//  ViewController.swift
//  TraningsWithPatterns
//
//  Created by Андрей Калюжный on 16.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myButton.addTarget(self, action: #selector(pressButton(_:)), for: .touchUpInside)
        
        let myNotification = Notification.Name("myNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(notify(notification:)), name: myNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("myNotification"), object: nil)
    }
    
    @objc func notify(notification: Notification) {
        self.myButton.backgroundColor = .blue
    }

    @objc func pressButton(_ sender: UIButton) {
        let sub = Subject()
        let obsA = ObserverA()
        let obsB = ObserverB()
        sub.addObsrver(observer: obsA)
        sub.addObsrver(observer: obsB)
        
        sub.someBusinessLogic(numb: 8)
        //sub.someBusinessLogic(numb: 4)
        
        NotificationCenter.default.post(name: Notification.Name("myNotification"), object: nil)
    }
    
}

