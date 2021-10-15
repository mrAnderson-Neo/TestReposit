//
//  UserRespone.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 03.10.2021.
//

import Foundation

//final class Response: Decodable {
//    let response: UserResponse
//}
//
//class UserResponse: Decodable {
//    let arrUsers: [UserForApi]
//
//    enum CodingKeys: String, CodingKey {
//        case arrUsers = "items"
//    }
//}
//
//final class UserForApi: Decodable {
//    var idUser: Int64?
//    var testPole: String?
//    var name: String?
//
//    enum CodingKeys: String, CodingKey {
//        case idUser = "id"
//        case name = "first_name"
//        case testPole
//    }
//
//    required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.idUser = try values.decode(Int64.self, forKey: .idUser)
//        self.name = try values.decode(String.self, forKey: .name)
//
//    }
//}



class UserForApi: Decodable {
    let response: Response
}

class Response: Decodable {
    let items: [UserApi]
}

class UserApi: Decodable {
    let userId: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case name = "first_name"
    }
}

