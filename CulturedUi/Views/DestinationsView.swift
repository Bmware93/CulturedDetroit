//
//  DestinationsView.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 5/19/23.
//

import SwiftUI
import MapKit


struct DestinationsView: View {
    
    @EnvironmentObject  var vm: DestinationsViewModel
    @StateObject  var locationManager = LocationManager()
    
    // if the http request fails, we'll show an alert with the error reason
    @State private var isShowingErrorAlert = false
    @State private var errorAlertText = ""
    
    // if we have tapped on a map annotation, we'll pass a Business instance here, and our sheet will show us the details
    @State private var detailBusiness: Destination?

    var body: some View {
        // MARK: MAPVIEW and Drop Menu
        ZStack {
            Map(coordinateRegion: $vm.mapRegion, interactionModes: .all, showsUserLocation: true,
                userTrackingMode: .constant(.none), annotationItems: vm.destinations) {
                destination in
                MapAnnotation(coordinate: destination.clCoordinate) {
                    VStack {
                        Button {
                            // if we tap on a business, pass the business to this property so our sheet will show
                           detailBusiness = destination
                        } label: {
                            AnnotationView(destination: destination)
                        }

                        
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
//                ForEach(vm.tasks) { task in
//                    Button {
//                        _Concurrency.Task {
//                            do {
//                               // print("this is the coordinate\(vm.mapRegion.center)")
//                                try await vm.businesses(searchingFor: task.searchTerm, at: vm.mapRegion.center)
//                            } catch {
//                                print(error.localizedDescription)
//                            }
//                           
//                        }
//                        
//                    } label: {
//                       Text(task.description)
//                    }
//                    .buttonStyle(.borderedProminent)
//                }
            }
            BottomDrawerView()
        }
        
        // the .sheet(item:) call allows us to only show the sheet if we've passed a business to the detailBusiness property.
        .sheet(item: $detailBusiness, content: { business in
            BusinessDetailView(destination: business)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium])
        })

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
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 54)
                        .padding(.trailing, 20)
                        .overlay(alignment: .leading) {
                    Image(systemName: "chevron.down")
                            .font(.system(size: 25))
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.primary)
                            .padding()
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
