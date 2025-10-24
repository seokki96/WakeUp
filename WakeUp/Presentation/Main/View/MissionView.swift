//
//  MissionView.swift
//  WakeUp
//
//  Created by a on 10/24/25.
//

import SwiftUI

struct MissionView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            VStack {
                Text("미션을 해결하세요!")
                    .font(.title)
                    .padding(.top, 20)
                Spacer()
                Text("1")
                    .font(.system(size: 140, weight: .bold))
                Spacer()
                MainButton(title: "미션완료") {
                    NotificationCenter.default.post(name: .closeMissionView, object: nil)
                }
            }
            .padding()
        }
    }
}

#Preview {
    MissionView()
}
