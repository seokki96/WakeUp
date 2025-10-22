//
//  Alarm+CoreDataProperties.swift
//  WakeUp
//
//  Created by a on 10/18/25.
//
//

public import Foundation
public import CoreData


public typealias AlarmCoreDataPropertiesSet = NSSet

extension Alarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarm> {
        return NSFetchRequest<Alarm>(entityName: "Alarm")
    }

    @NSManaged public var id: UUID
    @NSManaged public var isActive: Bool
    @NSManaged public var title: String?
    @NSManaged public var time: Date
    @NSManaged public var alarmList: [String]

}

extension Alarm : Identifiable {

}
