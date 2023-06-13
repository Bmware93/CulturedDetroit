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
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(vm.tasks, id: \.self) { task in
                        HStack(alignment: .center) {
                            Image(task.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .frame(width: 150, height: 150)
                                .padding(.trailing)
                                .shadow(radius: 3 , x: 2, y: 2)
                            VStack(alignment: .leading) {
                                Text(task.description)
                                    .font(.system(size: fontSize))

                                    .minimumScaleFactor(0.5) // Adjust as needed
                                    .lineLimit(1)
                                
                                Button {
                                    _Concurrency.Task {
                                        do {
                                            
                                            try await vm.businesses(searchingFor: task.searchTerm, at: vm.mapRegion.center)
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                        
                                    }
                                    
                                } label: {
                                    Text("Search")

                                        .padding(6)
                                        .font(.system(size: fontSize))
                                        .minimumScaleFactor(0.5) // Adjust as needed
                                    .lineLimit(1)

                                }
                                //
                                //                                        .font(.system(size: fontSize))
                                //                                        .minimumScaleFactor(0.5) // Adjust as needed
                                //                                    .lineLimit(1)
                                //                                }
                                .buttonStyle(.borderedProminent)
                                .shadow(radius: 3 , x: 2, y: 2)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Activities")
        }
    }
}

struct PendingTaskListView_Previews: PreviewProvider {
    static var previews: some View {
        PendingTaskListView()
            .environmentObject(DestinationsViewModel())
    }
}

