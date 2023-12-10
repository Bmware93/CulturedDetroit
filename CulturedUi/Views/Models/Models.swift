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
    var image_url: URL?
    let coordinates: DestionationCoordinates
    var review_count: Int
    var rating: Double
    var location: Businesslocation
    var display_phone: String
 
    
    var clCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
  public func launchNavigationToAppleMaps() {
        let placemark = MKPlacemark(coordinate: clCoordinate)
        let mapItem = MKMapItem(placemark: placemark)
        
        // Set the destination name (optional)
        mapItem.name = name
        
        // Set the launch options for navigation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }

}

struct DestionationCoordinates: Codable {
    var latitude: Double
    var longitude: Double
}

struct Businesslocation: Codable {
    var address1: String
    var city: String
    var zip_code: String
    var state: String
//    var display_address: [String]?
}

//struct DestinationViewModel {
// var destination: Destination? // Holds the fetched destination data
//    
//    // Function to fetch destination data from the API
//   func fetchDestinationData() {
//        // Code to fetch destination data from Yelp Fusion API
//        // Assign the fetched destination data to self.destination
//    }
//}


struct Task: Identifiable, Hashable, Codable {
    var id = UUID()
    let searchTerm: String
    let description: String
    let imageName: String
    var isCompleted: Bool = false
    
    init(searchTerm: String, description: String, imageName: String) {
        // put initialization logic here
        self.description = description
        self.searchTerm = searchTerm
        self.imageName = imageName
    }
        
//        init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            self.searchTerm = try container.decode(String.self, forKey: .searchTerm)
//            self.description = try container.decode(String.self, forKey: .description)
//            self.imageName = try container.decode(String.self, forKey: .imageName)
//            self.isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
//        }
    
    static func load() -> [Task] {
        return [
            Task(searchTerm: "Pizza", description: "Eat pizza from a local restaurant.", imageName: "nikisDetPizzaPic"),
            Task(searchTerm: "Coffee", description: "Purchase a chai latte.", imageName: "lattePic"),
            Task(searchTerm: "Seafood", description: "Try seafood dish.", imageName: "salmonDishPic"),
            Task(searchTerm: "Riverwalk", description: "Enjoy a walk along the river.", imageName: "detWalkingPathPic")
        ]
    }
}

enum DistrictAreas: String, CaseIterable {
    case capitolPark = "Capital Park"
    case greektown = "Greektown"
    case atwater = "Atwater"
    case waterFront = "Waterfront"
    case campusMartius = "Campus Martius"
    case grandCircusPark = "Grand Circus Park"
    case theBelt = "The Belt"
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





