//
//  Photos.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 30.09.2021.
//

import Foundation

protocol ProtocolPhoto: AnyObject {
    var namePhoto: String { get set }
}

class Photo: ProtocolPhoto {
    var namePhoto: String
    
    init(namePhoto: String) {
        self.namePhoto = namePhoto
    }
}
