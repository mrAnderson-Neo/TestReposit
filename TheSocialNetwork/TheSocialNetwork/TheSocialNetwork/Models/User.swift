//
//  User.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 04.09.2021.
//

import UIKit
import RealmSwift




class User: Object, ProtocolUser {
    //var avatar: String?
    //var arrayFotos: [String]?
    var arrayFotos: [UIImage]?
    @objc dynamic var idUser: Int = 1
    //@objc dynamic var idForBase: Int = 0
    @objc dynamic var name: String = ""
    var age: UInt16 = 0
    var avatar: UIImage?
    
    override class func primaryKey() -> String? {
        return "idUser"
    }
    
    init(name: String, age: UInt16, avatar: UIImage?, arrayFotos: [UIImage]?) {
        self.name = name
        self.age = age
        self.avatar = avatar
        self.arrayFotos = arrayFotos
    }
    
    init(name: String, age: UInt16, avatar: UIImage?) {
        self.name = name
        self.age = age
        self.avatar = avatar
    }
    
    init(name: String, age: UInt16) {
        self.name = name
        self.age = age
    }
    
    init(name: String, age: UInt16, idUser: Int) {
        self.name = name
        self.age = age
        self.idUser = idUser
    }
    
    required init() {
        super.init()
        //fatalError("init() has not been implemented")
    }
    
//    required init() {
//        super.init()
//        //idForBase = 123
//    }
    
//    enum CodingKeys: String, CodingKey {
//        //case idUser = "id"
//        case name = "first_name"
//    }
}
