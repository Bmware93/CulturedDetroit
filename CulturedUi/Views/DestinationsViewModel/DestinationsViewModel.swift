//
//  DestinationsViewModel.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 5/19/23.
//

import Foundation
import SwiftUI
import MapKit


///This class allows us to write/read any of our models to/from the app's documents directory.
final class DirectoryService {
    public static func readModelFromDisk<T: Decodable>() -> [T] {
        do {
            let directory = try FileManager.default
                .url(for: .documentDirectory,
                     in: .userDomainMask,
                     appropriateFor: nil,
                     create: false)
            let encodedModels = try Data(contentsOf: directory.appendingPathComponent("\(T.self).json"))
            let decodedModels = try JSONDecoder()
                .decode([T].self, from: encodedModels)
            return decodedModels
        } catch {
            debugPrint(error)
            return []
        }
    }
    
    public static func writeModelToDisk<T:Encodable>(_ models: [T]) {
        do {
            let directory = try FileManager.default
                .url(for: .documentDirectory,
                     in: .userDomainMask,
                     appropriateFor: nil,
                     create: false)
            try JSONEncoder()
                .encode(models)
                .write(to: directory.appendingPathComponent("\(T.self).json"))
        } catch {
            debugPrint(error)
        }
    }
}

class DestinationsViewModel: ObservableObject {
    
    //All loaded locations
    @Published var destinations: [Destination]
    @Published var tasks: [Task]
    //    @Published var completedTasks: [Task] = []
    
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
    
    // MARK: Save Restart Alert
    @Published var showingResetAlert = false
    
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
        loadData()
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
    
    func completeTask(index: Int) {
        var task = tasks[index]
        task.isCompleted = true
        tasks[index] = task
        saveData()
        
    }
    
    //    Create a property that filters out a completed task from a pending one
    var isCompleted: [Task] {
        return tasks.filter { $0.isCompleted }
    }
    
    func restartProgress() {
        DirectoryService.writeModelToDisk([Task]())
        loadData()
    }
    
    var progressPercentage: Double {
        //        Create a guard statement that allow us to make a conditional for if a tasks is completed.
        
        let completedTasks: [Task] = tasks.filter { $0.isCompleted }
        
        return Double(completedTasks.count) / Double(tasks.count)
    }
    
    private func saveData() {
        DirectoryService.writeModelToDisk(tasks)
    }
    
    private func loadData() {
        let tasks: [Task] = DirectoryService.readModelFromDisk() as [Task]
        if tasks.isEmpty {
            self.tasks = Task.tasks
            return
        }
        self.tasks = tasks
    }
}
