//
//  TestEntity.swift
//  TestRealm
//
//  Created by Андрей Калюжный on 10.10.2021.
//

import Foundation
import RealmSwift

class TestEntity: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var gender = true
    @objc dynamic var petName = ""
    
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
