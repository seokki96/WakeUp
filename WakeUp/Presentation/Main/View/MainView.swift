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
            if viewModel.isActiveAlarm {
                Text("⏰ \(viewModel.nextAlarm) 뒤 알람")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(.gray.opacity(0.3))
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
            }
            
            LazyVStack(spacing: 14) {
                ForEach(viewModel.alarmList.indices, id: \.self) { idx in
                    HStack {
                        if viewModel.deleteMode {
                            Button {
                                viewModel.deleteAlarm(viewModel.alarmList[idx])
                            } label: {
                                Text("삭제")
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        // alarmList가 바뀔떄까지 업데이트 안됨
                        AlarmView(alarm: Binding(get: {
                            // 삭제시 인덱스 오류 방지
                            if idx > viewModel.alarmList.count-1 {
                                return AlarmEntity(id: "", title: "", time: .now, notiRequests: [], isActive: false, repeatDay: [])
                            } else {
                                return viewModel.alarmList[idx]
                            }
                        }, set: {
                            viewModel.alarmList[idx] = $0
                            viewModel.updateAlarm($0)
                        }))
                        .onTapGesture {
                            viewModel.showAlarmSettingView(alarm: viewModel.alarmList[idx])
                        }
                    }
                }
            }
            .padding(16)
        }
        .navigationBarItems(trailing: menuButton)
        .navigationBarItems(leading: completeButton)
        .background(.customBackground)
        .overlay(alignment: .bottomTrailing) {
            AddButton {
                viewModel.showAlarmSettingView()
            }
            .offset(x: -16)
        }
        .fullScreenCover(item: $viewModel.fullScreenCover, onDismiss: {
            Task {
                await viewModel.fetchAlarm()
            }
        }, content: { destination in
            switch destination {
            case .alarmSetting(let alarm):
                AlarmSettingView(viewModel: AlarmSettingViewModel(alarm: alarm))
            }
            
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
    
    private var menuButton: some View {
        Menu {
            Button {
                withAnimation {
                    viewModel.deleteMode = true
                }
            } label: {
                Label("알람 삭제", systemImage: "trash")
            }
            
        } label: {
            Image(systemName: "ellipsis")
                .foregroundStyle(.white)
        }
    }
    
    private var completeButton: some View {
        Button("완료") {
            withAnimation {
                viewModel.deleteMode = false
            }
        }
        .opacity(viewModel.deleteMode ? 1 : 0)
        .disabled(!viewModel.deleteMode)
    }
}

#Preview {
    MainView()
}

