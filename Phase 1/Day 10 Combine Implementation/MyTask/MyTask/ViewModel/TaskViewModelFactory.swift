//
//  TaskViewModelFactory.swift
//  MyTask
//
//  Created by CodeCat15 on 7/4/23.
//

import Foundation

final class TaskViewModelFactory {
    static func createTaskViewModel() -> TaskViewModel {
        return TaskViewModel(taskRepository: TaskRepositoryImplementation())
    }
}
