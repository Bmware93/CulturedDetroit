//
//  DestinationsListView.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 5/19/23.
//

import SwiftUI

struct DropMenuListView: View {
    
    @EnvironmentObject private var vm: DestinationsViewModel
    
    
    var body: some View {
        VStack {
            ForEach(vm.districts) { district in
                Button {
                    vm.showNextZone(zone: district)
                } label: {
                    listRowView(district: district)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
                Divider()
            }
        }
        .padding()
    }
}

struct DestinationsListView_Previews: PreviewProvider {
    static var previews: some View {
        DropMenuListView()
            .environmentObject(DestinationsViewModel())
    }
}

extension DropMenuListView {
    
   private  func listRowView(district: District) -> some View {
           VStack(alignment: .leading) {
               Text(district.name.rawValue)
                       .font(.title2)
                       .foregroundColor(.primary)
              
           }
           .frame(maxWidth: .infinity, alignment: .leading)
      
    }
}
