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
                        print("delete task")
                    } label: {
                        Text("Delete")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment:.center)
                    }

                }
                
            }.navigationTitle("Task Detail")
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
                            print("Update button tapped")
                        } label: {
                            Text("Update")
                        }
                    }
                }
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(taskViewModel: TaskViewModel(),
                       showTaskDetailView: .constant(false),
                       selectedTask: .constant(Task.createMockTasks().first!))
    }
}
