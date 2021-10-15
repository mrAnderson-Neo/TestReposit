//
//  SubjectObserver.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 12.10.2021.
//

import Foundation
import SwiftUI


enum TypeOfDownload {
    case friends
    case groups
}


class Subject {
    
    private lazy var observers = [Observer]()
    
    var typeOfDownload: TypeOfDownload = .friends
    
    func addObserver(observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(observer: Observer) {
        if let index = self.observers.firstIndex(where: {$0 === observer}) {
            observers.remove(at: index)
        }
    }
    
    func launchDownloads(_ typeOfDownload: TypeOfDownload) {
        self.typeOfDownload = typeOfDownload
        notify()
    }
    
    func notify() {
        observers.forEach( { $0.update(subject: self) } )
    }
}
