//
//  ObserverB.swift
//  TraningsWithPatterns
//
//  Created by Андрей Калюжный on 16.09.2021.
//

import Foundation

class ObserverB: Observer {
    func update(subject: Any) {
        guard let sub = subject as? Subject else {
            return
        }
        if sub.someValue <= 5{
            print("worked obsrver B")
        }
    }
    
    
}
