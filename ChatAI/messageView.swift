//
//  messageView.swift
//  ChatAI
//
//  Created by Aditya Anand on 02/04/25.
//

import SwiftUI
let exampleMessage : Message = .init(content: "Hello", isUser: true)

struct messageView : View {
    var message : Message
    var body: some View {
        Group{
            if message.isUser {
                HStack {
                    Spacer()
                    Text(message.content)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            } else {
                HStack {
                    Text(message.content)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    Spacer()
                }
                .padding(.leading, 8)
            }
        }
    }
}

#Preview {
    messageView(message: exampleMessage)
}
