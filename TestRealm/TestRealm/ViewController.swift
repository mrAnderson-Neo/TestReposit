//
//  ViewController.swift
//  TestRealm
//
//  Created by Андрей Калюжный on 04.10.2021.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet var myButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myButton.addTarget(self, action: #selector(pressMybutton(_:)), for: .touchUpInside)
    }


    @objc func pressMybutton(_ button: UIButton) {
        do {
            let realm = try Realm()
            let data = realm.objects(TestEntity.self)
            for testEn in data {
                print(testEn.name, testEn.id, testEn.age)
            }
        } catch {
            print(error)
        }
    }
    
    
    
}

