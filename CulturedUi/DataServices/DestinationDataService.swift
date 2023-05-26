//
//  DestinationDataService.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 5/18/23.
//

import Foundation
import MapKit

class DestinationDataService {
    
    static var destinations: [Destination] { [
     
        Destination(name: "Parc", coordinates: CLLocationCoordinate2D(latitude: 42.33164991655891, longitude: -83.04692610496726), district: District(name: .Downtown, coordinates: CLLocationCoordinate2D(latitude: 42.333145, longitude: -83.049562))),
        
        Destination(name: "Shake Shack", coordinates: CLLocationCoordinate2D(latitude: 42.33118989421314, longitude: -83.04592832325179), district: District(name: .Downtown, coordinates: CLLocationCoordinate2D(latitude: 42.333145, longitude: -83.049562))),
        
        Destination(name: "Texas de Brazil", coordinates: CLLocationCoordinate2D(latitude: 42.3326175387873, longitude: -83.04702266448813), district: District(name: .Downtown, coordinates: CLLocationCoordinate2D(latitude: 42.333145, longitude: -83.049562)))
        
        
        ]
    }
    
    static var districts: [District] {[
        District(name: .Downtown, coordinates: CLLocationCoordinate2D(latitude: 42.333145, longitude: -83.049562)),
        District(name: .Greektown, coordinates: CLLocationCoordinate2D(latitude: 42.334624982721174, longitude: -83.04242105238075)),
        District(name: .FoxTheater, coordinates: CLLocationCoordinate2D(latitude: 42.33870684018478, longitude: -83.05230182973283))
    ]
    }
}
