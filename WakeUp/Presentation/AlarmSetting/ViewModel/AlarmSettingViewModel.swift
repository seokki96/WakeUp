//
//  AlarmSettingViewModel.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import Combine
import SwiftUI

enum AlarmSettingPath: Hashable {
    case sound
    case mission
}

final class AlarmSettingViewModel: ObservableObject {
    @Published var path: [AlarmSettingPath] = []
    @Published var weekDays: Set<Weekday> = []
    @Published var title = ""
    @Published var time = Date()
    
    private let dataManager: CoreDataManager
    
    init(dataManager: CoreDataManager = CoreDataManager.shared) {
        self.dataManager = dataManager
    }
    
    func goToSoundView() {
        path.append(.sound)
    }
    
    func goToMissionView() {
        path.append(.mission)
    }
    
    func selecteDay(_ day: Weekday) {
        if weekDays.contains(day) {
            weekDays.remove(day)
        } else {
            weekDays.insert(day)
        }
    }
    
    func saveAlarm() {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "test"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("sampleSound.caf"))
        
        let hour = Calendar.current.component(.hour, from: time)
        let minute = Calendar.current.component(.minute, from: time)
        let center = UNUserNotificationCenter.current()
        
        let alarmGroupId = UUID().uuidString
        var requests = Set<UNNotificationRequest>()
        
        weekDays.forEach { weekDay in
            let id = "\(alarmGroupId)-\(UUID().uuidString)"
            var date = DateComponents()
            date.hour = hour
            date.minute = minute
            date.weekday = weekDay.rawValue
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            
            requests.insert(request)
            center.add(request) { error in}
        }
        
        let alarmEntity = AlarmEntity(
            id: alarmGroupId,
            title: title,
            time: time,
            notiRequests: Array(requests) as! [UNNotificationRequest],
            isActive: true,
            repeatDay: Array(weekDays)
        )
        
        dataManager.addAlarm(alarm: alarmEntity)
    }
}
