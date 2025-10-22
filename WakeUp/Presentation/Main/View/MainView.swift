//
//  MainView.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: MainViewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                ForEach($viewModel.alarmList, id: \.self) { alarm in
                    AlarmView(alarm: alarm) {
                        viewModel.updateAlarm($0)
                    }
                }
            }
            .padding(16)
        }
        .background(.customBackground)
        .overlay(alignment: .bottomTrailing) {
            AddButton {
                viewModel.addAlarm()
            }
        }
        .fullScreenCover(isPresented: $viewModel.isShowAddAlarm, onDismiss: {
            Task {
                await viewModel.fetchAlarm()
            }
        }, content: {
            AlarmSettingView(viewModel: AlarmSettingViewModel())
        })
        .alert(isPresented: $viewModel.isShowAlert) {
            Alert(
                title: Text("설정"),
                message: Text("알림 권한을 허용하지 않으면 알림이 울리지 않을 수 있습니다"),
                primaryButton: .default(Text("설정하기"), action: {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(appSettings) {
                            UIApplication.shared.open(appSettings)
                        }
                    }
                }),
                secondaryButton: .cancel(Text("취소"))
            )
        }
        .task {
            await viewModel.requestPermission()
            await viewModel.fetchAlarm()
        }
    }
}




#Preview {
    MainView()
}

