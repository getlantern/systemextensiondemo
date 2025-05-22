//
//  SystemExtenstionTestApp.swift
//  SystemExtenstionTest
//
//  Created by Adam Fisk on 5/21/25.
//

import SwiftUI

@main
struct SystemExtenstionTestApp: App {
    
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
