//
//  iOS_projectApp.swift
//  iOS_project
//
//  Created by Apple on 12/05/24.
//

import SwiftUI

@main
struct iOS_projectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
