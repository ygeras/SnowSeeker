//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Yuri Gerasimchuk on 29.07.2022.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private var saveKey = "Favorites"
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Favorites")
    
    init() {
        // load our saved data
        /*
         do {
            let data = try Data(contentsOf: savePath)
            let decoder = JSONDecoder()
            resorts = try decoder.decode(Set<String>.self, from: data)
        } catch {
            // still here? Use an empty arra
            resorts = []
        }
         */
        
        // init using UserDefaults
        if let saved = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: saved) {
                resorts = decoded
                return
            }
        }
        resorts = []
    }
        
    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write our data
        /*
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(resorts)
            try data.write(to: savePath)
        } catch {
            print("Error. Unable to save data!")
        }
         */
        
        // save using UserDefaults
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
}
