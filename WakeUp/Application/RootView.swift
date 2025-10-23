//
//  RootView.swift
//  WakeUp
//
//  Created by a on 10/24/25.
//

import SwiftUI

struct RootView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = .tabbar
    }
    var body: some View {
        TabView {
            NavigationStack {
                MainView()
                    .environmentObject(MainViewModel())
            }
            .tabItem {
                Image(systemName: "deskclock")
                Text("알람")
            }
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("설정")
                }
        }
    }
}

#Preview {
    RootView()
}
