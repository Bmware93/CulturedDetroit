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
        List {
            ForEach(vm.districts) { district in
                Button {
                    vm.showNextZone(zone: district)
                } label: {
                    listRowView(district: district)

                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)



            }
        }
        .listStyle(.grouped)
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
                       .font(.headline)
                       .foregroundColor(.primary)
              
           }
           .frame(maxWidth: .infinity, alignment: .leading)
      
    }
}

//extension DistrictsListView {
//    private func listRowView(zone: Zone) -> some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(zone.name)
//                    .font(.system(size: 20))
//                    .minimumScaleFactor(0.5)
//                    .font(.headline)
//                    .foregroundColor(.primary)
//            }
//            // makes all of the text the same width
//            .frame(maxWidth: .infinity, alignment: .leading)
//        }
//    }
//}
