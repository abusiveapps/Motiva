//
//  MotivaBApp.swift
//  MotivaB
//
//  Created by   on 11/7/24.
//

import SwiftUI
import SwiftData

@main
struct MotivaBApp: App {
    let container: ModelContainer = {
        let schema = Schema([Source.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            SelectTagsView()
        }
        .modelContainer(container)
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
