//
//  ShoppingItemController.swift
//  Shopping List
//
//  Created by Michael Stoffer on 5/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class ShoppingListController {
    
    init() {
        if self.shoppingItemsPreference == false {
            self.setShoppingItems()
        } else {
            self.loadFromPersistentStore()
        }
    }
    
    // MARK: - Variables
    private (set) var shoppingItems: [ShoppingItem] = []
    let shoppingPreferenceKey = "shoppingPreferenceKey"
    
    var shoppingItemsAdded: [ShoppingItem] {
        return self.shoppingItems.filter { $0.hasBeenAdded == true }
    }
    
    var shoppingItemsPreference: Bool? {
        return UserDefaults.standard.bool(forKey: shoppingPreferenceKey)
    }
    
    private var shoppingFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentsDirectory.appendingPathComponent("shopping.plist")
    }
    
    // MARK: - Methods
    func createShoppingItem(withName name: String) {
        let shoppingItem = ShoppingItem(withName: name)
        shoppingItems.append(shoppingItem)
        self.saveToPersistentStore()
    }
    
    func updateHasBeenAdded(for item: ShoppingItem) {
        guard let i = shoppingItems.firstIndex(of: item) else { return }
        shoppingItems[i].hasBeenAdded = !shoppingItems[i].hasBeenAdded
        self.saveToPersistentStore()
    }
    
    private func setShoppingItems() {
        let itemNames = ["Apple", "Grapes", "Milk", "Muffin", "Popcorn", "Soda", "Strawberries"]
        for name in itemNames {
            self.createShoppingItem(withName: name)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: shoppingPreferenceKey)
    }
    
    // MARK: - Persistence
    func saveToPersistentStore() {
        guard let url = self.shoppingFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let shoppingItemData = try encoder.encode(self.shoppingItems)
            try shoppingItemData.write(to: url)
        } catch {
            NSLog("Error saving shoppingItems data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = self.shoppingFileURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let shoppingItemData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            self.shoppingItems = try decoder.decode([ShoppingItem].self, from: shoppingItemData)
        } catch {
            NSLog("Error loading shoppingItems data: \(error)")
        }
    }
}
