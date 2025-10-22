//
//  AlarmView.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import SwiftUI

struct AlarmView: View {
    let alarm: AlarmEntity
    @Binding var isOn: Bool
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(alarm.title)
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                    Toggle("", isOn: $isOn)
                }
                HStack(alignment: .firstTextBaseline) {
                    Text("\(alarm.meridiem)")
                    Text("\(alarm.dateString)")
                        .font(.system(size: 40, weight: .bold))
                    Spacer()
                }
                HStack {
                    ForEach(alarm.dayArray, id: \.self) {
                        Text($0)
                    }
                }
            }
            .padding(16)
        }
        .background(.main)
        .cornerRadius(12)
    }
}

//#Preview {
//    AlarmView(isOn: .constant(true))
//}
