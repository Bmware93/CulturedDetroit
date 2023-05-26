//
//  Models.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 5/17/23.
//

import Foundation
import MapKit

struct User: Identifiable {
    let  id = UUID()
    let currentLocation: CLLocation
}


struct District: Identifiable {
    let id = UUID()
    let name: DistrictAreas
    let coordinates: CLLocationCoordinate2D

}

struct Destination: Identifiable {
    let id = UUID()
    let name: String
    let coordinates: CLLocationCoordinate2D
    let district: District
}


struct Task: Identifiable {
    let id = UUID()
    let title: String
    
}

enum DistrictAreas: String, CaseIterable {
    case Downtown, Greektown, FoxTheater
}


struct DowntownCoords {
   static var latitude: Double = 42.333145
    var longitude: Double = -83.049562
        
    }


