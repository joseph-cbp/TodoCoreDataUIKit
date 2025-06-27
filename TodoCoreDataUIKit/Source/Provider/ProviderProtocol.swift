//
//  ProviderProtocol.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 27/06/25.
//

import Foundation
import CoreData

protocol ProviderProtocol: AnyObject {
    var container: NSPersistentContainer { get } 
    
    var context: NSManagedObjectContext { get }
}
