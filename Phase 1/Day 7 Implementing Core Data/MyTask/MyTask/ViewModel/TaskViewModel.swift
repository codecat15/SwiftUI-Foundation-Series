//
//  TaskViewModel.swift
//  MyTask
//
//  Created by CodeCat15 on 6/24/23.
//

import Foundation

final class TaskViewModel : ObservableObject {
    
    private let taskRepository: TaskRepository
    @Published var tasks: [Task] = []
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func getTasks(isCompleted: Bool) {
        self.tasks = taskRepository.get(isCompleted: !isCompleted)
    }
    
    func addTask(task: Task) -> Bool {
       return taskRepository.add(task: task)
    }
    
    func updateTask(task: Task) -> Bool {
        return taskRepository.update(task: task)
    }
    
    func deleteTask(task: Task) -> Bool {
        return taskRepository.delete(task: task)
    }
}
