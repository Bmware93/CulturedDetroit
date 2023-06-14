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
    
    @Published var districts:[District] = [
        
    ]
    
    //Current location on the map
    @Published var mapLocation: District {
        didSet {
            updateMapRegion(district: mapLocation)
        }
    }
    //Current District on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    public static var mapSpan = MKCoordinateSpan(latitudeDelta: 0.0060, longitudeDelta: 0.0060)
    
    //Show list of districts
    @Published var showZonesList: Bool = false
    
    @Published var progress: Double = 0
    @Published var selectedViewCategory: ViewCategories = .activities
    
    init() {
        let districts = DestinationDataService.districts
        self.destinations = []
        self.districts = districts
        self.mapLocation = districts.first!
        
        self.tasks = [
            Task(searchTerm: "coffee", description: "Purchase a chai latte.", imageName: "lattePic"),
            Task(searchTerm: "riverwalk", description: "Find a view of the Detroit River on foot.", imageName: "detWalkingPathPic"),
            Task(searchTerm: "pizza", description: "Eat local pizza.", imageName: "nikisDetPizzaPic"),
            Task(searchTerm: "park", description: "Have a treat in a park.", imageName: "detRiverfrontPic"),
            Task(searchTerm: "seafood", description: "Try seafood dish.", imageName: "salmonDishPic"),
            Task(searchTerm: "empanada", description: "Try an Empanada.", imageName: "empanadaPic"),
//            Task(searchTerm: "landmark", description:  "I'm bronze and embody the spirit of Detroit, where am I?", imageName: "landmarkPic"),
            Task(searchTerm: "?", description: "Enjoy bumper cars", imageName: "midwayBumperPic"),
            Task(searchTerm: "mural", description: "Explore the city's street art", imageName: "streetArtPic"),
            Task(searchTerm: "taco", description: "Have a taco...or three.", imageName: "tacosPic"),
            Task(searchTerm: "park", description: "Have lunch in a park.", imageName: "detRiverfrontPic"),
            Task(searchTerm: "coney", description: "Try a Detroit style Coney", imageName: "coneyDogPic"),
            Task(searchTerm: "?", description: "Go get some buckets", imageName: "midwayHoopPic"),
//            Task(searchTerm: "landmark", description:  "I protect the Spirit of Detroit with a fist of bronze and steel. Where am I?", imageName: "landmarkPic"),
            Task(searchTerm: "bakery", description:  "Enjoy a treat from a bakery.", imageName: "bakeTreatPic"),
            
        ]
        self.updateMapRegion(district: districts.first!)
    }
    
    @MainActor
    //Function that calls the API 
    func businesses(searchingFor term: String, at location: CLLocationCoordinate2D) async throws {
        let destinations = try await YelpFusionAPIService().businesses(searchingFor: term, at: location)
        
        self.destinations = destinations
    }

    
    private func updateMapRegion(district: District) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: district.coordinates,
                                           span: DestinationsViewModel.mapSpan)
        }
    }
    
     func toggleDistrictsList() {
        withAnimation(.easeInOut) {
            showZonesList.toggle()
        }
    }
    
    
    // MARK: Drop Menu List Functions
    
    func showNextZone(zone: District) {
        withAnimation(.easeInOut) {
            mapLocation = zone
            showZonesList = false
        }
    }
    
    func completeTask(task: Task) {
        if let index = tasks.firstIndex(of: task) {
            var task = task
            task.isCompleted = true
            tasks.remove(at: index)
            completedTasks.append(task)
            // save [task] to filepath
            progress = Double(completedTasks.count) / Double(completedTasks.count + tasks.count)
        }
    }
}
