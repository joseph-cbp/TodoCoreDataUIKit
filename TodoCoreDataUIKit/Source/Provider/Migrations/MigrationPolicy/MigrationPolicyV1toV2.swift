//
//  V1toV2.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 14/07/25.
//
import Foundation
import CoreData

class MigrationPolicyV1toV2: NSEntityMigrationPolicy {
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        let context = manager.destinationContext
        let entityName = mapping.destinationEntityName!
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            throw NSError(domain: "MigrationPolicyV1toV2", code: 1, userInfo: [NSLocalizedDescriptionKey : "Could not find entity \(entityName)"])
        }
        
        let destinationInstance = NSManagedObject(entity: entity, insertInto: context)
        destinationInstance.setValue(UUID(), forKey: "id")
        
        copyFields(from: sInstance, to: destinationInstance)
        
        manager.associate(sourceInstance: sInstance, withDestinationInstance: destinationInstance, for: mapping)
        
        
    }
    
    private func copyFields(from source: NSManagedObject, to destination: NSManagedObject){
        let sourceEntity = source.entity
        
        for attribute in sourceEntity.attributesByName {
            let attributeName = attribute.key
            
            if attributeName == "id" {continue}
            
            if let value = source.value(forKey: attributeName) {
                destination.setValue(value, forKey: attributeName)
            }
        }
    }
}
