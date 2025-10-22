//
//  Alarm.swift
//  WakeUp
//
//  Created by a on 10/20/25.
//

import Foundation
import UserNotifications
import SwiftUI

struct AlarmEntity: Hashable, Identifiable {
    let id: String
    var title: String
    var time: Date
    var notiRequests: [UNNotificationRequest]
    var isActive: Bool
    var repeatDay: [Weekday]
    
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
}

