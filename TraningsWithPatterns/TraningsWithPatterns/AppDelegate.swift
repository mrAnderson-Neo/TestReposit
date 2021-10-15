//
//  AppDelegate.swift
//  TraningsWithPatterns
//
//  Created by Андрей Калюжный on 16.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // создадим url
        //let url = URL(string: "http://samples.openweathermap.org/data/2.5/forecast?q=München,DE&appid=b1b15e88fa797225412429c1c50c122a1")
        
        // создаём конструктор для  URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "http"
        urlConstructor.host = "samples.openweathermap.org"
        urlConstructor.path = "/data/2.5/forecast"
        urlConstructor.queryItems = [
            URLQueryItem(name: "q", value: "München,DE"),
            URLQueryItem(name: "appid", value: "b1b15e88fa797225412429c1c50c122a1")
        ]
        
        
        guard let url = urlConstructor.url else {
            return true
        }
        
        // сессия по умолчанию
        //let session = URLSession.shared
        
        // создаём конфигурацию
        let configuration = URLSessionConfiguration.default
        
        // создаём свою сессию
        let session = URLSession(configuration: configuration)
        
        // задача для запуска
        let task = session.dataTask(with: url) { (data, responce, error) in
            // создадим json
            let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print(json)
//            print("data: \n", data)
//            print("responce: \n", responce)
//            print("error: \n", error)
            
        }
        
        task.resume()
        
        //let configuration = UIConfi
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

