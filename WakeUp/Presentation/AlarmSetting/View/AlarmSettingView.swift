//
//  AlarmSettingView.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import SwiftUI

struct AlarmSettingView: View {
    @StateObject var viewModel: AlarmSettingViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("알람 설정")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
                    }
                }
                .frame(height: 56)
                .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // 알람 이름
                        VStack(alignment: .leading, spacing: 8) {
                            Text("알람 이름")
                                .font(.system(size: 16, weight: .bold))
                            TextField("알람 이름을 입력해주세요", text: .constant(""))
                                .padding(12)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                        }
                        
                        // 시간 설정
                        VStack(alignment: .leading, spacing: 12) {
                            Text("시간 설정")
                                .font(.system(size: 16, weight: .bold))
                            DatePicker("", selection: .constant(.now), displayedComponents: .hourAndMinute)
                                .datePickerStyle(.wheel)
                                .labelsHidden()
                        }
                        
                        // 요일 설정
                        VStack(alignment: .leading, spacing: 12) {
                            Text("반복")
                                .font(.system(size: 16, weight: .bold))
                            HStack(alignment: .center, spacing: 10) {
                                ForEach(["월","화","수","목","금","토","일"], id: \.self) { day in
                                    Text(day)
                                        .font(.system(size: 14, weight: .medium))
                                        .frame(width: 36, height: 36)
                                        .background(Color.white.opacity(0.15))
                                        .cornerRadius(18)
                                }
                            }
                        }
                        
                        VStack(spacing: 12) {
                            SettingOption(title: "사운드", subtitle: "Bluebird") {
                                viewModel.goToSoundView()
                            }
                            SettingOption(title: "미션 선택", subtitle: "없음") {
                                viewModel.goToMissionView()
                            }
                        }
                    }
                    .padding(20)
                }
                
                MainButton(title: "설정 완료")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
            }
            .background(.customBackground)
            .navigationDestination(for: AlarmSettingPath.self) { path in
                switch path {
                case .sound:
                    SoundView()
                case .mission:
                    MissionView()
                }
            }
        }
    }
}

struct SettingOption: View {
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                }
                Spacer()
                Image(.rightIcon)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
        }
    }
}

#Preview {
    AlarmSettingView(viewModel: AlarmSettingViewModel())
}
