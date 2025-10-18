//
//  CoreDataManager.swift
//  WakeUp
//
//  Created by a on 10/18/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Alarm")
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func addAlarm() {
        let newAlarm = Alarm(context: context)
        newAlarm.title = "알람"
        newAlarm.isActive = true
        
        do {
            try context.save()
            print("데이터 추가 성공")
        } catch {
            print("Core Data save error: \(error)")
        }
    }
}
