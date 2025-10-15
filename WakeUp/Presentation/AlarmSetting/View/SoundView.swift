//
//  SoundView.swift
//  WakeUp
//
//  Created by a on 10/14/25.
//

import SwiftUI

struct SoundView: View {
    @State var isChecked: Bool = false
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(1..<10) { _ in
                    SoundItem(title: "제목", isChecked: $isChecked)
                }
            }
            .padding(16)
        }
        .background(.customBackground)
    }
}

#Preview {
    SoundView()
}
