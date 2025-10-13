//
//  MainView.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: MainViewModel
    @State var isOn = false
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                ForEach(1..<10) { _ in
                    AlarmView(isOn: $isOn)
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
        .fullScreenCover(isPresented: $viewModel.isShowAddAlarm) {
            AlarmSettingView(viewModel: AlarmSettingViewModel())
        }
    }
}

#Preview {
    MainView()
}
