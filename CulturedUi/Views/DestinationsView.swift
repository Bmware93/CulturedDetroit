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
                userTrackingMode: .constant(.none), annotationItems: vm.destinations) {
                destination in
                MapAnnotation(coordinate: destination.clCoordinate) {
                    VStack {
                
//                        Button {
                            // if we tap on a business, pass the business to this property so our sheet will show
                           //AnnotationView = destination
//                        } label: {
                            AnnotationView(destination: destination)
//                        }
//                        .buttonStyle(.borderless)
//                        //.buttonBorderShape(.capsule)
                        
//                        Text(destination.name)
//                            .font(.caption2)
                            
                    }
                   
                    
                }

            }
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                dropMenu
                    .padding()
                Spacer()
                
            }
            
            VStack {
                ForEach(vm.tasks) { task in
//                    Button {
//                        _Concurrency.Task {
//                            do {
//                                try await vm.businesses(searchingFor: task.searchTerm, at: vm.mapRegion.center)
//                            } catch {
//                                print(error.localizedDescription)
//                            }
//                           
//                        }
//                        
//                    } label: {
//                       Text(task.title)
//                    }
//                    .buttonStyle(.borderedProminent)
                }
            }
            BottomDrawerView()
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
        HStack(alignment: .top) {
            VStack {
                //MARK: Drop Down Menu
                Button(action: vm.toggleDistrictsList) {
                    Text(vm.mapLocation.name.rawValue)
                        .font(.system(size: 35))
                        .minimumScaleFactor(0.5)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 55)
                        .overlay(alignment: .leading) {
                    Image(systemName: "chevron.down")
                            .font(.system(size: 25))
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.primary)
                            .padding()
                            .padding(.trailing)
                            .rotationEffect(Angle(degrees: vm.showZonesList ? 180 : 0))
                    }
                }
                
                if vm.showZonesList == true {
                    DropMenuListView()
                }
            }
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
            .padding()
        }
    }
}
