//
//  Alarm.swift
//  WakeUp
//
//  Created by a on 10/20/25.
//

import Foundation
import UserNotifications

struct AlarmEntity: Hashable {
    let title: String
    let time: Date
    let alarmList: [UNNotificationRequest]
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "HH:mm"
        let dateString = formatter.string(from: time)
        return dateString
    }
    
    var meridiem: String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "a"
        let meridiem = formatter.string(from: time)
        return meridiem
    }
    
    var dayArray: [String] {
        alarmList
            .compactMap { $0.trigger as? UNCalendarNotificationTrigger }
            .compactMap { $0.dateComponents.weekday }
            .sorted()
            .compactMap { Weekday(rawValue: $0)?.dayName }
    }
}

