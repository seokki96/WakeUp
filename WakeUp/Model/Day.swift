//
//  Day.swift
//  WakeUp
//
//  Created by a on 10/15/25.
//

enum Day: CaseIterable {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    
    var dayName: String {
        switch self {
        case .sunday: return "일"
        case .monday: return "월"
        case .tuesday: return "화"
        case .wednesday: return "수"
        case .thursday: return "목"
        case .friday: return "금"
        case .saturday: return "토"
        }
    }
}
