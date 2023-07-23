//
//  AddTaskView.swift
//  MyTask
//
//  Created by CodeCat15 on 6/27/23.
//

import SwiftUI

struct AddTaskView: View {
    
    @ObservedObject var taskViewModel: TaskViewModel
    @State private var taskToAdd: Task = Task(id: 0, name: "", description: "", isCompleted: false, finishDate: Date())
    
    @Binding var showAddTaskView: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Task detail")) {
                    TextField("Task name", text: $taskToAdd.name)
                    TextEditor(text: $taskToAdd.description)
                }
                
                Section(header: Text("Task date/time")) {
                    DatePicker("Task date",selection: $taskToAdd.finishDate)
                }
            }.navigationTitle("Add Task")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showAddTaskView = false
                        } label: {
                            Text("Cancel")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Add button tapped")
                        } label: {
                            Text("Add")
                        }
                    }
                }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(taskViewModel: TaskViewModel(), showAddTaskView: .constant(false))
    }
}
