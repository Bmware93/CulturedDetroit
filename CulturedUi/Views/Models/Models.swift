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

struct Destination: Identifiable, Codable {
    var id: String
    let name: String
    let coordinates: DestionationCoordinates
    
    var clCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}

struct DestionationCoordinates: Codable {
    var latitude: Double
    var longitude: Double
}


struct Task: Identifiable {
    let id = UUID()
    let title: String
    let searchTerm: String
    
}

enum DistrictAreas: String, CaseIterable {
    case Downtown, Greektown, FoxTheater
}





