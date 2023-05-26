//
//  MapView.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 5/17/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region =
    MKCoordinateRegion(center:
    CLLocationCoordinate2D(latitude: 42.331687,
                           longitude:  -83.046632),
                       latitudinalMeters: 2000, longitudinalMeters: 2000)
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .all)
            .ignoresSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
