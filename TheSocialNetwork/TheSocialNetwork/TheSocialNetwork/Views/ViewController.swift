//
//  ViewController.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 03.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var buttonLogin: UIButton!
    @IBOutlet var textLogin: UITextField!
    @IBOutlet var textPassword: UITextField!
    
    let resueFromViewControllerToTaBarController = "fromViewControllerToTaBarController"

    override func viewDidLoad() {
        super.viewDidLoad()
        setSettings()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == resueFromViewControllerToTaBarController {
            //print("test")
        }
        
    }
    
    private func setSettings() {
        buttonLogin.layer.cornerRadius = ([buttonLogin.frame.width, buttonLogin.frame.height].min() ?? 1) / 10
        buttonLogin.addTarget(self, action: #selector(pressButtonLogin), for: .touchUpInside)
    }

    @objc func pressButtonLogin(_ sender: UIButton) {
        guard let login = textLogin.text,
              let password = textPassword.text,
              login == "", password == "" else {
            let alert = UIAlertController(title: "Unknowed user", message: "Invalid login or password",
                                          preferredStyle: .alert)
            let buttonOk = UIAlertAction(title: "Ok", style: .default) { _ in
                print("press ok")
            }

            alert.addAction(buttonOk)

            self.present(alert, animated: true, completion: nil)
            return
        }
        
        performSegue(withIdentifier: resueFromViewControllerToTaBarController, sender: nil)
    }

}

