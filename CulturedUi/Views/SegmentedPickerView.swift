//
//  SegmentedPickerView.swift
//  Cultured
//
//  Created by Omar Davidson II on 6/2/23.
//

import SwiftUI

struct SegmentedPickerView: View {
    @EnvironmentObject var vm: DestinationsViewModel
    let pendingTaskSearchCompletion: () -> Void
    var body: some View {
        VStack {
            Picker("Category", selection: $vm.selectedViewCategory) {
                ForEach(ViewCategories.allCases, id: \.self) { category in
                    Text(category.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)            
            if vm.selectedViewCategory == .activities {
                PendingTaskListView(vm: _vm, searchCompletion: pendingTaskSearchCompletion)
                    .padding(.top, 0)
            } else if vm.selectedViewCategory == .completed {
                CompletedTasksView(vm: vm)
            } else if vm.selectedViewCategory == .progress {
                DetroitDialView(vm: vm)
                Spacer()
                
            }
        }
    }
}

struct SegmentedPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPickerView(pendingTaskSearchCompletion: {})
            .environmentObject(DestinationsViewModel())
        
    }
}

