//
//  CompletedTasksView.swift
//  Cultured
//
//  Created by Omar Davidson II on 6/2/23.
//

import SwiftUI

struct CompletedTasksView: View {
    @ObservedObject var vm: DestinationsViewModel
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(vm.tasks, id: \.self) { task in
                        HStack {
                            Text(task.description)
                        }
                    }
                }
                Button(action: {
                    vm.showingResetAlert = true
                }) {
                    Text("Restart")
                        .foregroundColor(.red)
                }
                .alert(isPresented: $vm.showingResetAlert) {
                    Alert(
                        title: Text("Restart Progress"),
                        message: Text("Are you sure you want to restart your progress? This will remove all activities and reset your progress."),
                        primaryButton: .destructive(Text("Restart")) {
                            vm.restartProgress()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .navigationTitle("Completed")
        }
      
    }
}
struct CompletedTasksView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTasksView(vm: DestinationsViewModel())
    }
}
