//
//  Groups.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 06.09.2021.
//

import UIKit
import RealmSwift

protocol ProtocolGroup: AnyObject {
    var name: String { get set }
    var avatar: UIImage? { get set }
}

final class Group: Object, ProtocolGroup {
    var avatar: UIImage?
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    init(name: String, avatar: UIImage?) {
        self.name = name
        self.avatar = avatar
    }
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    required init() {
        super.init()
    }
}
