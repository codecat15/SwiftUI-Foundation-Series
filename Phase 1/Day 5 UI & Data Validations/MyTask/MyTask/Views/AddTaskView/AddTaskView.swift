//
//  AddTaskView.swift
//  MyTask
//
//  Created by CodeCat15 on 6/27/23.
//

import SwiftUI

struct AddTaskView: View {
    
    @ObservedObject var taskViewModel: TaskViewModel
    @State private var taskToAdd: Task = Task(id: 0,
                                              name: "",
                                              description: "",
                                              isCompleted: false,
                                              finishDate: Date())
    @Binding var showAddTaskView: Bool
    @Binding var refreshTaskList: Bool
    @State var showDirtyCheckAlert: Bool = false
    
    var pickerDateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let currentDateComponent = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
        
        let startDateComponent = DateComponents(year: currentDateComponent.year, month: currentDateComponent.month, day: currentDateComponent.day, hour: currentDateComponent.hour, minute: currentDateComponent.minute)
        
        let endDateComponent = DateComponents(year: 2024, month: 12, day: 31)
        
        return calendar.date(from: startDateComponent)!...calendar.date(from: endDateComponent)!
        
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Task detail")) {
                    TextField("Task name", text: $taskToAdd.name)
                    TextEditor(text: $taskToAdd.description)
                }
                
                Section(header: Text("Task date/time")) {
                    DatePicker("Task date", selection: $taskToAdd.finishDate, in: pickerDateRange)
                }
            }.navigationTitle("Add Task")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            
                            if(!taskToAdd.name.isEmpty){
                                showDirtyCheckAlert.toggle()
                            }else{
                                showAddTaskView.toggle()
                            }
                            
                        } label: {
                            Text("Cancel")
                        }.alert("Save task??", isPresented: $showDirtyCheckAlert) {
                            Button {
                                print("save existing task")
                            } label: {
                                Text("Add Task")
                            };
                            
                            Button(role:.cancel) {
                                showAddTaskView.toggle()
                            } label: {
                                Text("Cancel")
                            }

                        } message: {
                            Text("Would you like to save the task?")
                        }

                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if(taskViewModel.addTask(task: taskToAdd)) {
                                showAddTaskView.toggle()
                                refreshTaskList.toggle()
                            }
                        } label: {
                            Text("Add")
                        }.disabled(taskToAdd.name.isEmpty)
                        
                    }
                }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(taskViewModel: TaskViewModel(),
                    showAddTaskView: .constant(false),
                    refreshTaskList: .constant(false))
    }
}
