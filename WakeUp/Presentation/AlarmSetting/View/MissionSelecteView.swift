//
//  MissionView.swift
//  WakeUp
//
//  Created by a on 10/14/25.
//

import SwiftUI

struct MissionSelecteView: View {
    var body: some View {
        ScrollView {
            VStack {
                MissionItem(text: "걷기 미션")
            }
            .padding(.horizontal, 16)
        }
        .background(.customBackground)
        .navigationBarTitle(Text("미션 선택").font(.system(size: 18, weight: .bold)))
    }
}

#Preview {
    MissionSelecteView()
}
