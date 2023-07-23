//
//  TaskViewModel.swift
//  MyTask
//
//  Created by CodeCat15 on 6/24/23.
//

import Foundation

final class TaskViewModel : ObservableObject {
    
    @Published var tasks: [Task] = []
    
    func getTasks(isActive: Bool) {
        tasks = Task.createMockTasks().filter({$0.isCompleted == !isActive})
    }
    
}
