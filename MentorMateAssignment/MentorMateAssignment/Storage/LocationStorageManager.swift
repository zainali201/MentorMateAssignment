//
//  LocationStorageManager.swift
//  MentorMateAssignment
//
//  Created by Zain Ali on 5/21/22.
//

import Foundation
import UIKit
import CoreData

class LocationStorageManager
{
    let persistentContainer: NSPersistentContainer!
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    func fetchData() -> [Location] {
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? []
    }
    
    func fetchDataByID(id: String) -> [Location] {
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        request.predicate = NSPredicate(format: "id=%@", id)
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? []
    }
    
    func insert(id: String, address: String) -> Location? {
        guard let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: backgroundContext) as? Location else { return nil}
        location.id = id
        location.address = address
        save()
        return location
    }

    func save()
    {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
}
