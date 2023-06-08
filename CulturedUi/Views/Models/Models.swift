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


struct Task: Identifiable, Hashable {
    let id = UUID()
    let searchTerm: String
    let description: String
    let imageName: String
    var isCompleted: Bool = false
}

enum DistrictAreas: String, CaseIterable {
    case Downtown, Greektown, FoxTheater
}

enum ViewCategory: String, CaseIterable {
    case tasks
    case progress
    
    // MARK: Create Strings here so you can use SF symbols
}

enum ViewCategories: String, CaseIterable {
    case activities
    case completed
    case progress
}





