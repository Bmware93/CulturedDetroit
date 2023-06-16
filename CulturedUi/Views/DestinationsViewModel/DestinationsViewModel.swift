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
            Task(searchTerm: "river walk", description: "Find a view of the Detroit River on foot.", imageName: "detWalkingPathPic"),
            Task(searchTerm: "pizza", description: "Eat local pizza.", imageName: "nikisDetPizzaPic"),
            Task(searchTerm: "park", description: "Have a snack in a park.", imageName: "detRiverfrontPic"),
            Task(searchTerm: "seafood", description: "Try a seafood dish.", imageName: "salmonDishPic"),
            Task(searchTerm: "empanada", description: "Have an empanada.", imageName: "empanadaPic"),
            Task(searchTerm: "skating rinks", description: "Crash into some friends in bumper cars.", imageName: "midwayBumperPic"),
            Task(searchTerm: "icecream", description: "Have a scoop or two.", imageName: "iceCreamPic"),
            Task(searchTerm: "cocktails", description: "Grab a drink. (N/A or with Alcohol)", imageName: "drinkPic"),
            Task(searchTerm: "public art", description: "Explore some of Detroit's street art.", imageName: "streetArtPic"),
            Task(searchTerm: "golf", description: "Score a hole in one.", imageName: "indoorGolfPic1"),
            Task(searchTerm: "greek", description: "Enjoy a greek meal.", imageName: "greekFoodPic"),
            Task(searchTerm: "taco", description: "Have a taco...or three.", imageName: "tacosPic"),
            Task(searchTerm: "park", description: "Have lunch in a park.", imageName: "detRiverfrontPic"),
            Task(searchTerm: "coney", description: "Try a Detroit style Coney.", imageName: "coneyDogPic"),
            Task(searchTerm: "skating rinks", description: "Go get some buckets.", imageName: "midwayHoopPic"),
            Task(searchTerm: "bakery", description:  "Enjoy a treat from a bakery.", imageName: "bakedTreatsPic"),
            Task(searchTerm: "skating rinks", description: "Go roller skating.", imageName: "rollerSkatingPic"),
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
