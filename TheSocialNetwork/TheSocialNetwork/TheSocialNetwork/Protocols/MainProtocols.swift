//
//  MainProtocols.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 03.10.2021.
//

import UIKit
import RealmSwift

protocol Observer: AnyObject {
    func update(subject: Any)
}

protocol ProtocolUserForApi {
    var name: String { get set }
    var idUser: Int { get set }
    var age: UInt16 { get set }
    
}

protocol AdvancedProtocolUser {
    var avatar: UIImage? { get set }
    var arrayFotos: [UIImage]? { get set }
}

protocol ProtocolUser: ProtocolUserForApi, AdvancedProtocolUser, AnyObject {}
