//
//  MainViewModel.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import Combine
import UserNotifications

class MainViewModel: ObservableObject {
    @Published var isShowAddAlarm: Bool = false
    @Published var isShowAlert = false
    @Published var alarmList: [AlarmEntity] = []
    
    private let dataManager: CoreDataManager
    
    init(dataManager: CoreDataManager = .shared) {
        self.dataManager = dataManager
    }
    
    func addAlarm() {
        isShowAddAlarm.toggle()
    }
    
    func requestPermission() async {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()
        
        if settings.authorizationStatus == .notDetermined {
            do {
                if try await center.requestAuthorization(options: [.alert, .sound, .badge]) {
                    print("허용함")
                } else {
                    isShowAlert = true
                }
            } catch {
            }
        }
    }
    
//     데이터를 가져왔을떄 -> isActive 상태에 따라서 초기값 바인딩
    func fetchAlarm() async {
        let center = UNUserNotificationCenter.current()
        let requests = await center.pendingNotificationRequests()
       
        let result = dataManager.fetchAlarm()
        alarmList = result.map { alarm in
            return AlarmEntity(
                id: alarm.id,
                title: alarm.title ?? "",
                time: alarm.time,
                alarmList: requests.filter { alarm.alarmList.contains($0.identifier) },
                isActive: alarm.isActive
            )
        }
    }
    
    func updateAlarm(_ alarm: AlarmEntity) {
        do {
            try dataManager.updateAlarm(alarm: alarm)
        } catch {
            
        }
    }
}
