//
//  SoundItem.swift
//  WakeUp
//
//  Created by a on 10/15/25.
//

import SwiftUI

struct SoundItem: View {
    let title: String
    @Binding var isChecked: Bool
    
    var body: some View {
        HStack {
            Image(isChecked ? .checked : .notChecked)
            Text("제목제목제목제목")
            Spacer()
        }
        .onTapGesture {
            isChecked.toggle()
        }
    }
}

#Preview {
    SoundItem(title: "", isChecked: .constant(false))
}
