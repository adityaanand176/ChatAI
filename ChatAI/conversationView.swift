//
//  ContentView.swift
//  ChatAI
//
//  Created by Aditya Anand on 28/03/25.
//

import SwiftUI
import AIProxy

struct conversationView: View {
    @StateObject var chatController: ChatController = .init()
    @State var string: String = ""
    @State var chatTitle: String = "New Chat"
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack{
                VStack {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(spacing: 8) {
                                ForEach(chatController.messages) { message in
                                    messageView(message: message)
                                        .id(message.id)
                                        .padding(.horizontal, 8)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    
                    Divider()
                    
                    HStack(alignment: .bottom) {
                        TextField("Type to chat", text: $string, axis: .vertical)
                            .textFieldStyle(.plain)
                            .padding(12)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            .lineLimit(5)
                        
                        Button {
                            let message = Message(content: string, isUser: true)
                            chatController.messages.append(message)
                            Task{
                                await chatController.sendMessage(content: chatController.messages.last!.content)
                            }
                            if(chatController.messages.count == 1){
                                Task{
                                    chatTitle = try await chatController.provideTitle(for: chatController.messages.last!.content)
                                }
                                
                            }
                            string = ""
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .padding(10)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .padding(.vertical, 4)
                        }
                        .disabled(string.isEmpty)
                    }
                    .padding()
                }
                .navigationTitle(chatTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing){
                        Button {
                            print("User Profile")
                        } label: {
                            NavigationLink(destination: ProfileView()
                            ){
                                Text(user.initials)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(.white))
                                    .frame(width: 40, height: 40)
                                    .background(Color(.systemGray3))
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
            }
        }
        else {
            LoginView()
        }
    }
}

struct validationView : View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                conversationView()
            }
            else {
                LoginView()
            }
        }
    }
}

#Preview {
    conversationView()
}
