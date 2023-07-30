//
//  Task.swift
//  MyTask
//
//  Created by CodeCat15 on 6/24/23.
//

import Foundation

struct Task {
    let id: Int
    var name: String
    var description: String
    var isCompleted: Bool
    var finishDate: Date
    
    // Dev Note: This function will be modified once we introduce core data
    static func createMockTasks() -> [Task] {
        return [
            Task(id: 1, name: "Go to gym", description: "back workout", isCompleted: false, finishDate: Date()),
            Task(id: 2, name: "Car wash", description: "Downtown car wash center, this car wash center is good and has good reviews at google so why not try it out and also there's a 10% discount going on so try this one out", isCompleted: false, finishDate: Date()),
            Task(id: 3, name: "Office work", description: "Finish picker module", isCompleted: true, finishDate: Date())
        ]
    }
}
