//
//  HomeView.swift
//  MyTask
//
//  Created by CodeCat15 on 6/25/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var taskViewModel: TaskViewModel = TaskViewModel()
    @State private var pickerFilters: [String] = ["Active", "Closed"]
    @State private var defaultPickerSelectedItem: String = "Active"
    
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
                }
            }.onAppear{
                taskViewModel.getTasks(isActive: true)
            }.listStyle(.plain)
                .navigationTitle("Home")
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
