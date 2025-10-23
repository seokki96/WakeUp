//
//  MainButton.swift
//  WakeUp
//
//  Created by a on 10/14/25.
//

import SwiftUI

struct MainButton: View {
    let title: String
    var disabled: Bool = false
    var action: (() -> ())?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 55)
        }
        .disabled(disabled)
        .background(disabled ? .gray : .button)
        .cornerRadius(12)
    }
}

#Preview {
    MainButton(title: "완료")
}
