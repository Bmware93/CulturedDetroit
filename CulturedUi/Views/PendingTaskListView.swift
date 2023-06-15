//
//  PendingTaskListView.swift
//  Cultured
//
//  Created by Omar Davidson II on 6/2/23.
//

import SwiftUI

struct PendingTaskListView: View {
    @EnvironmentObject var vm: DestinationsViewModel
    @ScaledMetric var fontSize: CGFloat = 15 // Default font size
    let searchCompletion: () -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(vm.tasks, id: \.self) { task in
                        HStack(alignment: .center, spacing: 30) {
                            Image(task.imageName)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .frame(width: 170, height: 170)
                                .shadow(radius: 3 , x: 2, y: 2)
                            VStack(alignment: .leading) {
                                Text(task.description)
                                    .font(.system(size: fontSize))
                                    .minimumScaleFactor(2.5) // Adjust as needed
                                    .lineLimit(3)
                                
                                Button {
                                    _Concurrency.Task {
                                        do {
                                            
                                            try await vm.businesses(searchingFor: task.searchTerm, at: vm.mapRegion.center)
                                            searchCompletion()
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                        
                                    }
                                    
                                } label: {
                                    Text("Search")
                                        .font(.system(size: fontSize))
                                        .minimumScaleFactor(0.5) // Adjust as needed
                                        .lineLimit(1)
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .shadow(radius: 3 , x: 2, y: 2)
                            //                            .padding(.trailing)
                        }
                        .padding(.leading)
                    }
                }
            }
            .navigationBarTitle("Activities")
        }
        
    }
}



struct PendingTaskListView_Previews: PreviewProvider {
    static var previews: some View {
        PendingTaskListView(searchCompletion: {})
            .environmentObject(DestinationsViewModel())
    }
}

