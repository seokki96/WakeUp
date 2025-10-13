//
//  MainView.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import SwiftUI

struct MainView: View {
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
    }
}

#Preview {
    MainView()
}
