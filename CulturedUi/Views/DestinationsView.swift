//
//  DestinationsView.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 5/19/23.
//

import SwiftUI
import MapKit


struct DestinationsView: View {
    
    @EnvironmentObject private var vm: DestinationsViewModel
    @StateObject private var locationManager = LocationManager()

    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion, interactionModes: .all, showsUserLocation: true,
                userTrackingMode: .constant(.none))
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                dropMenu
                    .padding()
                Spacer()
            }
        }
    }
}

struct DestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationsView()
            .environmentObject(DestinationsViewModel())
    }
}

extension DestinationsView {
    
    private var dropMenu: some View {
        VStack {
            Button(action: vm.toggleDistrictsList) {
                Text(vm.mapLocation.name.rawValue)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                .frame(maxWidth:.infinity)
                //.background(Color.cyan)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                }
                
                if vm.showDistrictsList == true {
                    DropMenuListView()
                }
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        .padding()
    }
}
