//
//  MissionItem.swift
//  WakeUp
//
//  Created by a on 10/14/25.
//

import SwiftUI

struct MissionItem: View {
    let text: String
    var action: (()->())?
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack {
                Text(text)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(20)
        }
        .background(.main)
        .cornerRadius(12)
    }
}

#Preview {
    MissionItem(text: "걷기 미션")
}
