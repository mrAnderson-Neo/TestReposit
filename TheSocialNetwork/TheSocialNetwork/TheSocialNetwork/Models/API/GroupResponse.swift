//
//  GroupResponse.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 04.10.2021.
//

import Foundation

class GroupResponse: Decodable{
    let response: ResponseForGroup
}

class ResponseForGroup: Decodable {
    let items: [GroupApi]
}

class GroupApi: Decodable {
    let name: String
    let id: Int
}
