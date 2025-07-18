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
        copyFields(from: sInstance, to: destinationInstance)
        
        manager.associate(sourceInstance: sInstance, withDestinationInstance: destinationInstance, for: mapping)
        
        
    }
    
    private func copyFields(from source: NSManagedObject, to destination: NSManagedObject){
        let sourceEntity = source.entity
        let destinationEntity = destination.entity
        
        for attribute in destinationEntity.attributesByName {
            let attributeName = attribute.key
            
            if let value = source.value(forKey: attributeName) {
                destination.setValue(value, forKey: attributeName)
            } else if attributeName == "id" {
                destination.setValue(UUID(), forKey: attributeName)
            }
        }
    }
}
