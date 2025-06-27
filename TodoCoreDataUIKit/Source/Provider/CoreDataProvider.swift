//
//  CoreDataProvider.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 27/06/25.
//

import CoreData

class CoreDataProvider: ProviderProtocol {
    var container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    init(inMemory: Bool){
        container = NSPersistentContainer(name: "TodoCoreDataUIKit")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("cannot initialize persistent store: \(error.localizedDescription)")
            }
        }
    }
    
    
}
