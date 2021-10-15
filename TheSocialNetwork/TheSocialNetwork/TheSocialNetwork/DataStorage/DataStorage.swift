//
//  DataStorage.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 04.09.2021.
//

import UIKit

final class DataStorage {
    var token: String?
    var userId: String?
    
    var arrayUsers: [ProtocolUser] = [ProtocolUser]()
    var arrayGroups: [ProtocolGroup] = [ProtocolGroup]()
    var arrayAllGroup:[ProtocolGroup] = [ProtocolGroup]()
    var arrayPhoto: [String] = [String]()
    lazy var subj: Subject = Subject()
    static let dataStorage = DataStorage()
    
    private init() {
        /*
        fillInUsers()
        fillInGroups()
        arrayUsers.sort { user, user2 in
            user.name.lowercased() < user2.name.lowercased()
        }
        arrayAllGroup += arrayGroups
        fillInRestGroups()
         */
        
        token = "86800110a2e9eead2961974c27b21837d24aab5f7e00dce7e143c2d160d016b5365c3b051d327e9032a90"
        userId = "138271117"
    }
    
    private func fillInGroups() {
        arrayGroups.append(Group(name: "Nature", avatar: UIImage(named: "Nature")))
        arrayGroups.append(Group(name: "Science", avatar: UIImage(named: "Science")))
    }
    private func fillInRestGroups() {
        arrayAllGroup.append(Group(name: "Sport", avatar: nil))
        arrayAllGroup.append(Group(name: "Library of Knowledge", avatar: nil))
    }
    
    private func fillInUsers() {
        arrayUsers.append(User(name: "Brad Pitt", age: 56, avatar: UIImage.init(named: "Brad Pitt")
                               , arrayFotos: getFotos(name: "Brad")))
        arrayUsers.append(User(name: "Julia Roberts", age: 45, avatar: UIImage.init(named: "Julia Roberts")
                               , arrayFotos: getFotos(name: "Julia")))
        arrayUsers.append(User(name: "Leo Dicaprio", age: 52))
        arrayUsers.append(User(name: "Billy Bob Thornton", age: 67, avatar: UIImage.init(named: "Billy Bob Thornton")
                               , arrayFotos: getFotos(name: "Bill")))
    }
    
    private func getFotos(name nameForSearch: String) -> [UIImage]? {
        var continueSearching = true
        var counter = 1
        var arrayFotos = [UIImage]()
        while continueSearching {
            if let foundFoto = UIImage(named: "\(nameForSearch)\(counter)") {
                arrayFotos.append(foundFoto)
            } else {
                continueSearching = false
            }
            counter += 1
        }
        
        return arrayFotos.count == 0 ? nil: arrayFotos
    }
}
