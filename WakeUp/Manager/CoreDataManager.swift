//
//  CoreDataManager.swift
//  WakeUp
//
//  Created by a on 10/18/25.
//

import CoreData
import UserNotifications

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
    
    func addAlarm(alarm: AlarmEntity) {
        let newAlarm = Alarm(context: context)
        newAlarm.id = alarm.id
        newAlarm.title = alarm.title
        newAlarm.isActive = true
        newAlarm.time = alarm.time
        newAlarm.requestIDs = Array(alarm.notiRequests.map{$0.identifier})
        newAlarm.repeatDay = alarm.repeatDay.map { $0.rawValue }
        
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
    
    func updateAlarm(alarm: AlarmEntity) throws {
        let request: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", alarm.id as CVarArg)
        
        context.performAndWait {
            do {
                let data = try context.fetch(request)
                
                if var updateAlarm = data.first {
                    updateAlarm.isActive = alarm.isActive
                    updateAlarm.title = alarm.title
                    updateAlarm.time = alarm.time
                    updateAlarm.repeatDay = alarm.repeatDay.map(\.rawValue)
                    updateAlarm.requestIDs = Array(alarm.notiRequests.map(\.identifier))
                    try context.save()
                }
            } catch {
                print("Update error: \(error)")
            }
        }
    }
    
    func deleteAlarm(alarm: AlarmEntity) {
        let request: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", alarm.id as CVarArg)
        
        context.performAndWait {
            do {
                let data = try context.fetch(request)
                
                guard let deleteAlarm = data.first else {
                    return
                }
            
                context.delete(deleteAlarm)
                try context.save()
            } catch {
                print("Delete error: \(error)")
            }
        }
    }
}
