//
//  AlarmView.swift
//  WakeUp
//
//  Created by a on 10/24/25.
//

import SwiftUI

struct AlarmCompleteView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text("기상 완료")
                    .font(.largeTitle)
                Spacer()
                MainButton(title: "알람 끄기") {
                    NotificationCenter.default.post(name: .closeAlarmView, object: nil)
                }
            }
            .padding()
        }
    }
}

#Preview {
    AlarmCompleteView()
}
