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
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func getTasks(isCompleted: Bool) {
        let fetchOperationResult = taskRepository.get(isCompleted: !isCompleted)
        switch fetchOperationResult {
        case .success(let fetchedTasks):
            self.errorMessage = ""
            self.tasks = fetchedTasks
        case .failure(let failure):
            self.processOperationError(failure)
        }
    }
    
    func addTask(task: Task) -> Bool {
       let addOperationResult = taskRepository.add(task: task)
        return processOperationResult(operationResult: addOperationResult)
    }
    
    func updateTask(task: Task) -> Bool {
        let updateOperationResult = taskRepository.update(task: task)
        return processOperationResult(operationResult: updateOperationResult)
    }
    
    func deleteTask(task: Task) -> Bool {
        let deleteOperationResult = taskRepository.delete(task: task)
        return processOperationResult(operationResult: deleteOperationResult)
    }
    
    private func processOperationResult(operationResult: Result<Bool, TaskRepositoryError>) -> Bool {
        switch operationResult {
        case .success(let success):
            self.errorMessage = ""
            return success
        case .failure(let failure):
            self.processOperationError(failure)
            return false
        }
    }
    
    private func processOperationError(_ error: TaskRepositoryError) {
        switch error {
        case .operationFailure(let errorMessage):
            self.showError = true
            self.errorMessage = errorMessage
        }
    }
}
