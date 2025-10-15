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
    @Published var selectedDay: Set<Day> = []
    @Published var title = ""
    @Published var time = Date()
    
    func goToSoundView() {
        path.append(.sound)
    }
    
    func goToMissionView() {
        path.append(.mission)
    }
    
    func selecteDay(_ day: Day) {
        if selectedDay.contains(day) {
            selectedDay.remove(day)
        } else {
            selectedDay.insert(day)
        }
    }
}
