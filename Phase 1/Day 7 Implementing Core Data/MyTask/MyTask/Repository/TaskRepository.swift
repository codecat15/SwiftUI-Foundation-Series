//
//  TaskRepository.swift
//  MyTask
//
//  Created by CodeCat15 on 7/4/23.
//

import Foundation
import CoreData.NSManagedObjectContext

protocol TaskRepository {
    func get(isCompleted: Bool) -> [Task]
    func update(task: Task) -> Bool
    func add(task: Task) -> Bool
    func delete(task: Task) -> Bool
}

final class TaskRepositoryImplementation: TaskRepository {
    
    private let managedObjectContext: NSManagedObjectContext = PersistenceController.shared.viewContext
    
    func get(isCompleted: Bool) -> [Task] {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: isCompleted))
        
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            if(!result.isEmpty) {
                return result.map({Task(id: $0.id!,
                                        name: $0.name ?? "",
                                        description: $0.taskDescription ?? "",
                                        isCompleted: $0.isCompleted,
                                        finishDate: $0.finishDate ?? Date())})
            }
        }
        catch {
            print("error on get = \(error.localizedDescription)")
        }
        
        return []
        
    }
    
    func update(task: Task) -> Bool {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            if let existingTask = try managedObjectContext.fetch(fetchRequest).first {
                existingTask.name = task.name
                existingTask.taskDescription = task.description
                existingTask.finishDate = task.finishDate
                existingTask.isCompleted = task.isCompleted
                
                try managedObjectContext.save()
                return true
            } else {
                print("No task found with the id \(task.id)")
                return false
            }
        }
        catch {
            print("error on update = \(error.localizedDescription)")
        }
        
        return false
    }
    
    func add(task: Task) -> Bool {
        let taskEntity = TaskEntity(context: managedObjectContext)
        taskEntity.id = UUID()
        taskEntity.isCompleted = false
        taskEntity.name = task.name
        taskEntity.taskDescription = task.description
        taskEntity.finishDate = task.finishDate
        
        do {
            try managedObjectContext.save()
            return true
        }
        catch {
            print("error on add = \(error.localizedDescription)")
        }
        
        return false
    }
    
    func delete(task: Task) -> Bool {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            if let existingTask = try managedObjectContext.fetch(fetchRequest).first {
                managedObjectContext.delete(existingTask)
                try managedObjectContext.save()
            } else {
                print("Delete: No task found to delete with the id \(task.id)")
                return false
            }
        }catch {
            print("error on delete = \(error.localizedDescription)")
        }
        
        return false
    }
}
