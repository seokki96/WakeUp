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
    
    func addAlarm(title: String, time: Date, alarmList: Set<String>) {
        let newAlarm = Alarm(context: context)
        newAlarm.title = title
        newAlarm.isActive = true
        newAlarm.time = time
        newAlarm.alarmList = Array(alarmList)
        
        do {
            try context.save()
            print("데이터 추가 성공")
        } catch {
            print("Core Data save error: \(error)")
        }
    }
    
    func fetchAlarm() -> [Alarm] {
        context.performAndWait {
            let request: NSFetchRequest<Alarm> = Alarm.fetchRequest()
            
            do {
                let result = try context.fetch(request)                
                return result
            } catch {
                print("Fetch request error: \(error)")
            }
            return []
        }
    }
}
