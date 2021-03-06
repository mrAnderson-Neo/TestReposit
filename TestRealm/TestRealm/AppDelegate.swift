//
//  AppDelegate.swift
//  TestRealm
//
//  Created by Андрей Калюжный on 04.10.2021.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var arr = [TestEntity]()
        
        var testEntity = TestEntity()
        testEntity.id = 1
        testEntity.name = "Петр45"
        testEntity.age = 18
        testEntity.gender = true
        testEntity.petName = "Пушок"
        
        arr.append(testEntity)
        
        testEntity = TestEntity()
        testEntity.id = 2
        testEntity.name = "Ivan"
        testEntity.age = 18
        testEntity.gender = true
        testEntity.petName = "Jack"
        
        arr.append(testEntity)
        
        testEntity = TestEntity()
        testEntity.id = 3
        testEntity.name = "Petya"
        testEntity.age = 18
        testEntity.gender = true
        testEntity.petName = "Bro"
        
        arr.append(testEntity)
        
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            print(realm.configuration.fileURL)
            realm.beginWrite()
            realm.add(arr, update: .all)
            try realm.commitWrite()
            
        } catch {
            print(error)
        }


        
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

