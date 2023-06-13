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
        
        // MARK: Atwater
        District(name: .atwater, coordinates: CLLocationCoordinate2D(latitude: 42.336556, longitude: -83.019315)),
        // MARK: The Belt
        District(name: .theBelt, coordinates: CLLocationCoordinate2D(latitude: 42.334632, longitude: -83.046622)),
        //MARK: Campus Martius
        District(name: .campusMartius, coordinates: CLLocationCoordinate2D(latitude: 42.331545, longitude: -83.046635)),
        //MARK: Capitol Park
        District(name: .capitolPark, coordinates: CLLocationCoordinate2D(latitude: 42.332899, longitude: -83.049526)),
        // MARK: The Grand Circus Park
        District(name: .grandCircusPark, coordinates: CLLocationCoordinate2D(latitude: 42.336304, longitude: -83.051291)),
        // MARK: Greektown
        District(name: .greektown, coordinates: CLLocationCoordinate2D(latitude: 42.334103, longitude: -83.041788)),
        //MARK: Waterfront
        District(name: .waterFront, coordinates: CLLocationCoordinate2D(latitude: 42.328324, longitude: -83.039265)),
    ]
    }
}
