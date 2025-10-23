//
//  Date+.swift
//  WakeUp
//
//  Created by a on 10/23/25.
//

import Foundation

extension Date {
    var getTime: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: self)
        var todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        todayComponents.hour = dateComponents.hour
        todayComponents.minute = dateComponents.minute
        
        let today = calendar.date(from: todayComponents)!
        let now = Date()
        
        // 시간이 지난경우 다음날짜로 설정
        if today <= now {
            return calendar.date(byAdding: .day, value: 1, to: today)!
        } else {
            return today
        }
    }
}
