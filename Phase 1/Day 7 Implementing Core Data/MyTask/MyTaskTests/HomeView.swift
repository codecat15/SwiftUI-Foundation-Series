//
//  HomeView.swift
//  MyTask
//
//  Created by CodeCat15 on 6/25/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var taskViewModel: TaskViewModel = TaskViewModelFactory.createTaskViewModel()
    @State private var pickerFilters: [String] = ["Active", "Completed"]
    @State private var defaultPickerSelectedItem: String = "Active"
    @State private var showAddTaskView: Bool = false
    @State private var showTaskDetailView: Bool = false
    @State private var selectedTask: Task = Task.createEmptyTask()
    @State private var refreshTaskList: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            Picker("Picker filter", selection: $defaultPickerSelectedItem) {
                ForEach(pickerFilters, id:\.self) {
                    Text($0)
                }
            }.pickerStyle(.segmented)
                .onChange(of: defaultPickerSelectedItem) { newValue in
                    taskViewModel.getTasks(isCompleted: defaultPickerSelectedItem == "Active")
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
                taskViewModel.getTasks(isCompleted: true)
            }
            .onChange(of: refreshTaskList, perform: { _ in
                taskViewModel.getTasks(isCompleted: defaultPickerSelectedItem == "Active")
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
