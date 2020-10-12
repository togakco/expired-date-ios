//
//  expired_date_iosApp.swift
//  expired-date-ios
//
//  Created by fit-sys on 2020/10/12.
//

import SwiftUI

@main
struct expired_date_iosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
