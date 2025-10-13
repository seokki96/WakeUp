//
//  AlarmView.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import SwiftUI

struct AlarmView: View {
    @Binding var isOn: Bool
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("제목")
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                    Toggle("", isOn: $isOn)
                }
                Text("05:30")
                    .font(.system(size: 40, weight: .bold))
            }
            .padding(16)
        }
        .background(.main)
        .cornerRadius(12)
    }
}

#Preview {
    AlarmView(isOn: .constant(true))
}
