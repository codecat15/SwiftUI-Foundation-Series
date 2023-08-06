//
//  HomeView.swift
//  MyTask
//
//  Created by CodeCat15 on 6/25/23.
//

import SwiftUI

/**
 
 Hey there, I hope the session was helpful, please note that this code will be further improvised in the coming sessions giving you more details on what area of improvements are there in the code and how we can overcome those
 
 If you have any questions please feel free to ask, and do share the playlist with your iOS group.
 
 Regards,
 Ravi (CodeCat15)
 
 */

struct HomeView: View {
    
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @State private var pickerFilters: [String] = ["Active", "Completed"]
    @State private var defaultPickerSelectedItem: String = "Active"
    @State private var showAddTaskView: Bool = false
    @State private var showTaskDetailView: Bool = false
    @State private var selectedTask: Task = Task(id: 0,
                                                 name: "",
                                                 description: "",
                                                 isCompleted: false,
                                                 finishDate: Date())
    @State private var refreshTaskList: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            Picker("Picker filter", selection: $defaultPickerSelectedItem) {
                ForEach(pickerFilters, id:\.self) {
                    Text($0)
                }
            }.pickerStyle(.segmented)
                .onChange(of: defaultPickerSelectedItem) { newValue in
                    taskViewModel.getTasks(isActive: defaultPickerSelectedItem == "Active")
                }
            
            List(taskViewModel.tasks, id: \.id) { task in
                VStack(alignment:.leading) {
                    Text(task.name).font(.title)
                    
                    HStack {
                        Text(task.description).font(.subheadline)
                            .lineLimit(2)
                        Spacer()
                        Text(task.finishDate.toString()).font(.subheadline)
                    }
                }.onTapGesture {
                    selectedTask = task
                    showTaskDetailView.toggle()
                }
            }.onAppear{
                taskViewModel.getTasks(isActive: true)
            }
            .onChange(of: refreshTaskList, perform: { _ in
                taskViewModel.getTasks(isActive: defaultPickerSelectedItem == "Active")
            })
            .listStyle(.plain)
                .navigationTitle("Home")
            
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddTaskView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddTaskView) {
                    AddTaskView(taskViewModel: taskViewModel,
                                showAddTaskView: $showAddTaskView,
                                refreshTaskList: $refreshTaskList)
                }
                .sheet(isPresented: $showTaskDetailView) {
                    TaskDetailView(taskViewModel: taskViewModel,
                                   showTaskDetailView: $showTaskDetailView,
                                   selectedTask: $selectedTask,
                                   refreshTaskList: $refreshTaskList)
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
