//
//  CoreDataStack.swift
//  Affluence
//
//  Created by Sajan Shrestha on 7/25/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private let name: String
    
    init(named name: String) {
        
        self.name = name
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: name)
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        
        self.persistentContainer.viewContext
    }()
    
    func saveContext() {
        
        if managedContext.hasChanges {
            
            do {
                
                try managedContext.save()
            }
            catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
