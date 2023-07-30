//
//  TaskViewModel.swift
//  MyTask
//
//  Created by CodeCat15 on 6/24/23.
//

import Foundation

/* Dev notes: The code in the viewModel will change once we integrate core data.
              Task model is not a core data entity, it's a client contract.
              The core data entity will be introduced once we start implementing core data.

              Please feel free to ask questions,
              and do subscribe to the channel to stay updated with the Foundation series.
 
 Thanks,
 Ravi
 
 */

final class TaskViewModel : ObservableObject {
    
    @Published var tasks: [Task] = []
    private var tempTask = Task.createMockTasks()
    
    func getTasks(isActive: Bool) {
        tasks = tempTask.filter({$0.isCompleted == !isActive})
    }
    
    func addTask(task: Task) -> Bool {
        let taskId = Int.random(in: 4...100)
        let taskToAdd = Task(id: taskId,
                             name: task.name,
                             description: task.description,
                             isCompleted: false,
                             finishDate: task.finishDate)
        
        tempTask.append(taskToAdd)
        
        return true
    }
    
    func updateTask(task: Task) -> Bool {
        if let index = tempTask.firstIndex(where: {$0.id == task.id}) {
            
            tempTask[index].name = task.name
            tempTask[index].description = task.description
            tempTask[index].finishDate = task.finishDate
            tempTask[index].isCompleted = task.isCompleted
            
            return true
        }
        return false
    }
    
    func deleteTask(task: Task) -> Bool {
        if let index = tempTask.firstIndex(where: {$0.id == task.id}) {
            tempTask.remove(at: index)
            
            return true
        }
        return false
    }
}
