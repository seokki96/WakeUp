//
//  AlarmView.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import SwiftUI

struct AlarmView: View {
    @Binding var alarm: AlarmEntity    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(alarm.title)
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                    Toggle("", isOn: Binding(get: {
                        alarm.isActive
                    }, set: { isActive in
                        alarm.isActive = isActive
                    }))
                }
                HStack(alignment: .firstTextBaseline) {
                    Text("\(alarm.meridiem)")
                    Text("\(alarm.dateString)")
                        .font(.system(size: 40, weight: .bold))
                    Spacer()
                }
                HStack {
                    ForEach(alarm.repeatDay, id: \.self) {
                        Text($0.dayName)
                    }
                }
            }
            .padding(16)
        }
        .background(.main)
        .cornerRadius(12)
        .opacity(alarm.isActive ? 1 : 0.3)
    }
}

//#Preview {
//    AlarmView(isOn: .constant(true))
//}
