//
//  Task.swift
//  MyTask
//
//  Created by CodeCat15 on 6/24/23.
//

import Foundation

struct Task {
    let id: UUID
    var name: String
    var description: String
    var isCompleted: Bool
    var finishDate: Date
    
    static func createEmptyTask() -> Task {
        return Task(id: UUID(), name: "", description: "", isCompleted: false, finishDate: Date())
    }
}
