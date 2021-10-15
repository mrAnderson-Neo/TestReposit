//
//  MainProtocols.swift
//  TraningsWithPatterns
//
//  Created by Андрей Калюжный on 16.09.2021.
//

import Foundation

protocol Observer: AnyObject {
    func update(subject: Any)
}
