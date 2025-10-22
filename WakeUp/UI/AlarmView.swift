//
//  AlarmView.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import SwiftUI

struct AlarmView: View {
    @Binding var alarm: AlarmEntity
    var onToggle: ((AlarmEntity)->())
    
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
                        withAnimation {
                            alarm.isActive = isActive
                            onToggle(alarm)
                        }
                    }))
                    
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
        .opacity(alarm.isActive ? 1 : 0.3)
    }
}

//#Preview {
//    AlarmView(isOn: .constant(true))
//}
