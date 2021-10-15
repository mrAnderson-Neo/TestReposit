//
//  Subject.swift
//  TraningsWithPatterns
//
//  Created by Андрей Калюжный on 16.09.2021.
//

import Foundation

class Subject {
    /// получаем какое-то значение
    var someValue: Int = { return Int.random(in: 0...10) }()
    
    // храним список наблюдателей
    private lazy var observers: [Observer] = [Observer]()
    
    func addObsrver(observer: Observer) {
        observers.append(observer)
        print("observer added")
    }
    
    func removeObserver(observer: Observer) {
        if let index = self.observers.firstIndex(where:{ $0 === observer }) {
            observers.remove(at: index)
            print("observer deleted")
        }
    }
    
    func someBusinessLogic(numb: Int?) {
        if let getNumb = numb {
            someValue = getNumb
        } else {
            someValue = Int.random(in: 0...10)
        }
        notify()
    }
    
    func notify() {
        observers.forEach{ $0.update(subject: self) }
    }
}
