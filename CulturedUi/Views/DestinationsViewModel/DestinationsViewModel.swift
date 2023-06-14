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
    
    // MARK: BottomDrawer Manipulation
    @Published var offSet: CGFloat = 0
    @Published var isInitialOffsetSet: Bool = false
    @Published var drawerOffset: CGFloat = UIScreen.main.bounds.height - 100
    @Published var dragOffset: CGSize = .zero
    @Published var drawerHeights: [CGFloat] = [200, 300, 400]
    @Published var initialHeight: CGFloat = 490
    @Published var minHeight: CGFloat = 150
    @Published var maxHeight: CGFloat = 818

    
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
            Task(searchTerm: "Pizza", description: "Eat local pizza.", imageName: "nikisDetPizzaPic"),
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
