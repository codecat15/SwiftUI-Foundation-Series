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
    var isActive: Bool
    var finishDate: Date
    
    static func createMockTasks() -> [Task] {
        return [
            Task(id: 1, name: "Go to gym", description: "back workout", isActive: true, finishDate: Date()),
            Task(id: 2, name: "Car wash", description: "Downtown car wash center", isActive: true, finishDate: Date()),
            Task(id: 3, name: "Office work", description: "Finish picker module", isActive: false, finishDate: Date())
        ]
    }
}
