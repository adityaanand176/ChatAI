//
//  conversationViewModel.swift
//  ChatAI
//
//  Created by Aditya Anand on 02/04/25.
//

import SwiftUI
import AIProxy

struct Message : Identifiable {
    var id: UUID = .init()
    var content : String
    var isUser : Bool
}

@MainActor
class ChatController : ObservableObject {
    @Published var messages : [Message] = [.init(content: "Hello", isUser: false), .init(content: "Hello", isUser: true)]
//    @Published var messages : [Message] = []
    let openRouterService = AIProxy.openRouterDirectService(unprotectedAPIKey: constants.openRouterAPI.rawValue)
    
    func provideTitle(for conversation: String) async throws -> String{
        let content = "Give me a one-liner topic/subject/summary of the chat started with \(messages.last!.content). Do not write **Summary**: or anything similar, just give me a one-liner title. There is no need to explain a thing twice in the title, just a one-liner. I will do my best to give you a title that is concise and to the point. Say we have a prompt 'what is 2+2' and the reponse should be 'Basic Arithmetic' and not 'Basic Arithmetic: Calculating the sum of 2+2'"
        print(messages.last!.content)
        let requestBody = OpenRouterChatCompletionRequestBody(
            messages: [
                .system(content: .text("You are an assistant.")),
                .user(content: .text(content))
            ],
            includeReasoning: false,
            models: ["deepseek/deepseek-r1"],
            temperature: 0.9
        )
        
        do {
            let stream = try await openRouterService.streamingChatCompletionRequest(body: requestBody)
            var botReply = ""
            var tempMessage = Message(content: "", isUser: false)
            
            for try await chunk in stream {
                if let messageContent = chunk.choices.first?.delta.content {
                    botReply += messageContent
                    tempMessage.content = botReply
                }
            }
            return botReply
        } catch {
            print("Could not get bot reply: \(error.localizedDescription)")
            self.messages.append(Message(
                content: "Sorry, I encountered an error: \(error.localizedDescription)",
                isUser: false)
            )
        }
        return ""
    }
    
    func sendMessage(content: String) async {
        let userMessage = Message(content: content, isUser: true)
        print(userMessage)
        await getBotReply(for: messages)
    }
    
    func getBotReply(for messages: [Message]) async {
        let requestBody = OpenRouterChatCompletionRequestBody(
            messages: [
                .system(content: .text("You are an assistant.")),
                .user(content: .text(messages.last!.content))
            ],
            includeReasoning: false,
            models: ["deepseek/deepseek-r1"],
            temperature: 0.9
        )
        
        do {
            let stream = try await openRouterService.streamingChatCompletionRequest(body: requestBody)
            var botReply = ""
            var tempMessage = Message(content: "", isUser: false)
            self.messages.append(tempMessage)
            
            for try await chunk in stream {
                if let messageContent = chunk.choices.first?.delta.content {
                    botReply += messageContent
                    tempMessage.content = botReply
                    if let lastIndex = self.messages.indices.last {
                        self.messages[lastIndex] = tempMessage
                    }
                }
            }
            
        } catch {
            print("Could not get bot reply: \(error.localizedDescription)")
            self.messages.append(Message(
                content: "Sorry, I encountered an error: \(error.localizedDescription)",
                isUser: false)
            )
        }
    }
}
    
