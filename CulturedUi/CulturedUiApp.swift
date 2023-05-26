//
//  CulturedUiApp.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 5/17/23.
//

import SwiftUI

@main
struct CulturedUiApp: App {
    
    @StateObject private var vm = DestinationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            DestinationsView()
                .environmentObject(vm)
        }
    }
}
