//
//  MyTaskApp.swift
//  MyTask
//
//  Created by CodeCat15 on 7/15/23.
//

import SwiftUI

@main
struct MyTaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
