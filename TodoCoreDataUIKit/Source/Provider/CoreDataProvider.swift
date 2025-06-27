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
    
    static var preview: CoreDataProvider {
        let provider = CoreDataProvider(inMemory: true)
        let context = provider.context
        
        let todo1 = TodoItem(context: context)
        todo1.title = "Buy milk"
        todo1.detail = "Buy some milk from the dairy"
        
        let todo2 = TodoItem(context: context)
        todo2.title = "Learn SwiftUI"
        todo2.detail = "Read the documentation"
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
        
        return provider
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
