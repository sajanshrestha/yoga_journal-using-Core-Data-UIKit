//
//  YogaModel.swift
//  Yoga Journal
//
//  Created by Sajan Shrestha on 8/13/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class YogaModel {

    private(set) var yogas = [Yoga]()
        
    var title = "Yogas"
    
    var coreDataStack: CoreDataStack
    
    var delegate: YogaDelegate!
    
    init(coreDataStack: CoreDataStack) {
        
        self.coreDataStack = coreDataStack
        
        populateYogas(with: .all)
    }
}


// MARK:- CRUD operations

extension YogaModel {
    
    func populateYogas(with yogaFilter: YogaFilter) {
        
        let fetchRequest: NSFetchRequest<Yoga> = Yoga.fetchRequest()
        
        fetchRequest.predicate = yogaFilter.filteringPredicate
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { result in
                        
            if let receivedYogas = result.finalResult {
                self.yogas = receivedYogas
                
                self.delegate.didPopulateYogas()
                
            }
        }
        
        do {
            
            try coreDataStack.managedContext.execute(asyncFetchRequest)            
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
    func addYoga(name: String, duration: Int16, date: Date, note: String? = nil) {
        
        let context = coreDataStack.managedContext
        
        let yoga = Yoga(context: context)
        yoga.name = name.capitalize()
        yoga.duration = duration
        yoga.date = date
        yoga.note = note
        
        coreDataStack.saveContext()
        
        yogas.insert(yoga, at: 0)
    }
    
    func update(_ yoga: Yoga, with imageData: Data?) {
        yoga.image = imageData
        coreDataStack.saveContext()
    }

    func delete(at index: Int) {
        
        let yoga = yogas[index]
        
        coreDataStack.managedContext.delete(yoga)
        coreDataStack.saveContext()
        
        yogas.remove(at: index)
    }
    
    func deleteAllYogas() {
        
        yogas = []
                    
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Yoga")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            
            try coreDataStack.managedContext.execute(batchDeleteRequest)
        }
        catch {
            
            print(error.localizedDescription)
        }
    }
}



extension YogaModel {
    
    func getTotalDuration() -> Int? {
        
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "Yoga")
        
        fetchRequest.resultType = .dictionaryResultType
        
        let durationSumExpressionDescription = getExpressionDescription(for: "sumDurations", forFunction: "sum:")
        
        durationSumExpressionDescription.expressionResultType = .integer16AttributeType
                
        fetchRequest.propertiesToFetch = [durationSumExpressionDescription]
        
        do {
            let results = try coreDataStack.managedContext.fetch(fetchRequest)
            let resultDict = results.first!
            let durationSum = resultDict["sumDurations"] as? Int
            
            return durationSum
            
            
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getAverageDuration() -> Double? {
        
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "Yoga")
        
        fetchRequest.resultType = .dictionaryResultType
        
        let averageDurationDescription = getExpressionDescription(for: "averageDuration", forFunction: "average:")
                
        averageDurationDescription.expressionResultType = .doubleAttributeType
        
        fetchRequest.propertiesToFetch = [averageDurationDescription]
        
        do {
            let results = try coreDataStack.managedContext.fetch(fetchRequest)
            let resultDict = results.first!
                        
            let average = resultDict["averageDuration"] as? Double
            
            return average
            
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    private func getExpressionDescription(for name: String, forFunction function: String) -> NSExpressionDescription {
        
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = name
        
        let expression = NSExpression(forKeyPath: #keyPath(Yoga.duration))
        
        expressionDescription.expression = NSExpression(forFunction: function, arguments: [expression])
        
        return expressionDescription
    }
    
    func getTotalNumberOfYogas() -> Int? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Yoga")
        
        fetchRequest.resultType = .countResultType
        
        do {
            
            let result = try coreDataStack.managedContext.fetch(fetchRequest)
            
            guard let count = result.first as? Int else { return nil }
            
            return count
        }
        
        catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
}
