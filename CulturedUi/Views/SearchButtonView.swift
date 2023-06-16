//
//  SearchButtonView.swift
//  CulturedUi
//
//  Created by Omar Davidson II on 6/16/23.
//

import SwiftUI

struct SearchButtonView: View {
    @EnvironmentObject var vm: DestinationsViewModel
    let task: Task
    @ScaledMetric var fontSize: CGFloat = 15 // Default font size
    let searchCompletion: () -> Void
    @State var isLoading = false
    var body: some View {
        Button {
            _Concurrency.Task {
                isLoading = true
                do {
                    try await vm.businesses(searchingFor: task.searchTerm, at: vm.mapRegion.center)
                    searchCompletion()
                } catch {
                    print(error.localizedDescription)
                }
                isLoading = false
            }
            
        } label: {
            Text("Find Locations")
                .padding(.top, 4)
                .padding(.bottom, 4)
                .font(.system(size: fontSize))
                .minimumScaleFactor(0.5) // Adjust as needed
                .lineLimit(1)
                .opacity(isLoading ? 0.0 : 1.0)
        }
        .buttonStyle(.borderedProminent)
        .shadow(radius: 3 , x: 2, y: 2)
        .overlay {
            if isLoading {
                ProgressView()
                    .tint(.white)
            }
        }
    }
}

struct SearchButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SearchButtonView(task: Task(searchTerm: "uyuy", description: "bg", imageName: ""), searchCompletion: { })
    }
}
