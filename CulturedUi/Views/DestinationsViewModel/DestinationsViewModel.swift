//
//  DestinationsViewModel.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 5/19/23.
//

import Foundation
import SwiftUI
import MapKit

class DestinationsViewModel: ObservableObject {
    
    //All loaded locations
    @Published var destinations: [Destination]
    @Published var tasks: [Task]
    @Published var completedTasks: [Task] = []
    
    @Published var districts:[District]
    
    //Current location on the map
    @Published var mapLocation: District {
        didSet {
            updateMapRegion(district: mapLocation)
        }
    }
    //Current District on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    public static var mapSpan = MKCoordinateSpan(latitudeDelta: 0.0090, longitudeDelta: 0.0090)
    
    //Show list of districts
    @Published var showDistrictsList: Bool = false
    
    @Published var progress: Double = 0
    @Published var selectedViewCategory: ViewCategories = .activities
    
    init() {
        let districts = DestinationDataService.districts
        self.destinations = []
        self.districts = districts
        self.mapLocation = districts.first!
        
        self.tasks = [
            Task(searchTerm: "Pizza", description: "Eat pizza from a local restaurant.", imageName: "nikisDetPizzaPic"),
            Task(searchTerm: "Coffee", description: "Purchase a chai latte.", imageName: "lattePic"),
            Task(searchTerm: "Seafood", description: "Try seafood dish.", imageName: "salmonDishPic"),
            Task(searchTerm: "Riverwalk", description: "Enjoy a walk along the river.", imageName: "detWalkingPathPic"),
            Task(searchTerm: "Pizza", description: "Eat pizza from a local restaurant.", imageName: "nikisDetPizzaPic"),
            Task(searchTerm: "Coffee", description: "Purchase a chai latte.", imageName: "lattePic"),
            Task(searchTerm: "Seafood", description: "Try seafood dish.", imageName: "salmonDishPic"),
            Task(searchTerm: "Riverwalk", description: "Enjoy a walk along the river.", imageName: "detWalkingPathPic"),
            Task(searchTerm: "Pizza", description: "Eat pizza from a local restaurant.", imageName: "nikisDetPizzaPic"),
            Task(searchTerm: "Coffee", description: "Purchase a chai latte.", imageName: "lattePic"),
            Task(searchTerm: "Seafood", description: "Try seafood dish.", imageName: "salmonDishPic"),
            Task(searchTerm: "Riverwalk", description: "Enjoy a walk along the river.", imageName: "detWalkingPathPic"),

        ]
        self.updateMapRegion(district: districts.first!)
    }
    
    //Function that calls the API 
    func businesses(searchingFor term: String, at location: CLLocationCoordinate2D) async throws {
        self.destinations = try await YelpFusionAPIService().businesses(searchingFor: term, at: location)
    }

    
    private func updateMapRegion(district: District) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: district.coordinates,
                                           span: DestinationsViewModel.mapSpan)
        }
    }
    
     func toggleDistrictsList() {
        withAnimation(.easeInOut) {
            showDistrictsList.toggle()
        }
    }
    
    func showNextDistrict(district: District) {
        withAnimation(.easeInOut) {
            mapLocation = district
            showDistrictsList = false
        }
    }
    
    func completeTask(task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
            completedTasks.append(task)
            progress = Double(completedTasks.count) / Double(completedTasks.count + tasks.count)
            
        }
    }
}
