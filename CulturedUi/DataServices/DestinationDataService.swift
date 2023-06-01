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
     
  
        ]
    }
    
    static var districts: [District] {[
        District(name: .Downtown, coordinates: CLLocationCoordinate2D(latitude: 42.333145, longitude: -83.049562)),
        District(name: .Greektown, coordinates: CLLocationCoordinate2D(latitude: 42.334624982721174, longitude: -83.04242105238075)),
        District(name: .FoxTheater, coordinates: CLLocationCoordinate2D(latitude: 42.33870684018478, longitude: -83.05230182973283))
    ]
    }
}
