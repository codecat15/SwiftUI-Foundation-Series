//
//  TaskDetailView.swift
//  MyTask
//
//  Created by CodeCat15 on 6/27/23.
//

import SwiftUI

struct TaskDetailView: View {
    
    @ObservedObject var taskViewModel: TaskViewModel
    @Binding var showTaskDetailView: Bool
    @Binding var selectedTask: Task
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Task detail")) {
                    TextField("Task name", text: $selectedTask.name)
                    TextEditor(text: $selectedTask.description)
                    Toggle("Mark complete", isOn: $selectedTask.isCompleted)
                }
                
                Section(header: Text("Task date/time")) {
                    DatePicker("Task date",selection: $selectedTask.finishDate)
                }
                
                Section{
                    Button {
                        showDeleteAlert.toggle()
                        
                    } label: {
                        Text("Delete")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment:.center)
                    }
                }
                
                .alert("Delete Task?", isPresented: $showDeleteAlert) {
                    Button {
                        showTaskDetailView.toggle()
                    }label: {
                        Text("No")
                    }
                    Button(role:.destructive) {
                        taskViewModel.deleteTask(task: selectedTask)
                    }label: {
                        Text("Yes")
                    }
                } message: {
                    Text("Would you like to delete the task \(selectedTask.name)?")
                }
                
                
            }.onReceive(taskViewModel.shouldDismissView, perform: { _ in
                showTaskDetailView.toggle()
            })
            .navigationTitle("Task Detail")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showTaskDetailView.toggle()
                        } label: {
                            Text("Cancel")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            taskViewModel.updateTask(task: selectedTask)
                        } label: {
                            Text("Update")
                        }.disabled(selectedTask.name.isEmpty)
                    }
                }
                .alert("Task Error",
                       isPresented: $taskViewModel.error.showError,
                         actions: {
                    Button(action: {}) {
                        Text("Ok")
                    }
                },
                         message: {
                    Text(taskViewModel.error.errorMessage)
                })
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(taskViewModel: TaskViewModelFactory.createTaskViewModel(),
                       showTaskDetailView: .constant(false),
                       selectedTask: .constant(Task.createEmptyTask()))
    }
}
