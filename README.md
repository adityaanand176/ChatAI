# 🤖 ChatAI — Smart Conversational App

ChatAI is a sleek and powerful conversational application that integrates **DeepSeek API** via **OpenRouter** and leverages **Firebase** for authentication and account management. With a strong focus on API design, context-aware chat flow, and seamless user experience, ChatAI is designed to be both functional and developer-friendly.

---

## ✨ Features

- 🔐 **Firebase Authentication** (Sign Up / Sign In / Delete Account)
- 🔄 **DeepSeek API Integration** via OpenRouter
- 🧠 **Context-Aware Chat**: Chat headline updates dynamically based on chat content
- 🎨 **Polished UI** with responsive design
- 🧰 Modular and scalable **backend & network architecture**

---

## 📱 Screenshots

> will be adding screenshots soon

---

## 🧩 Tech Stack

- **Language**: Swift
- **Backend**: Firebase
- **AI Model**: DeepSeek API via OpenRouter
- **UI Framework**: SwiftUI
- **Database**: Firebase

---

## 🔧 Project Structure

```
├── constants.Swift        # API Key for OpenRouter + DeepSeek
├── firebase/              # Firebase Auth calls
├── models/                # Data models
├── views/                 # UI components
├── viewmodels/            # State management
├── ChatAI.swift           # Entry point
```

---

## 🌐 API Implementation

- All requests are routed via **OpenRouter** using an API key
- Chat messages are sent as HTTP POST requests
- Responses are parsed and rendered in real-time
- Headers and authentication managed securely

> Check `ConversationViewModel.swift` for implementation details.

---

## 🔥 Firebase Implementation

- **Sign Up / Sign In / Delete Account**
- Uses **Firebase Authentication SDK**
- Error handling with user feedback
- Secure session management

> See `AuthViewModel.swift` for functions and logic.

---

## 🎨 UI Design

- Clean and minimal interface
- Dynamic chat bubbles
- State-based rendering for loading/errors
- Auto-scroll and context headline updates

> Visit `ConversationView.swift, LoginView.swift, etc` for UI layout and interaction.

---

## 🧠 Chat Context & Headline

- On receiving a response, the app parses the message context
- The top headline dynamically updates to reflect the core topic
- Helps users stay aware of conversation flow and themes

> Logic handled inside `ChatViewModel.swift` → `provideTitle()` method

---

## 🏗️ Backend Design

- Lightweight client-driven architecture
- Stateless with Firebase session support
- All AI logic handled via OpenRouter proxy to DeepSeek

---

## 🚀 Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/adityaanand176/ChatAI.git
   cd ChatAI
   ```

2. Setup dependencies:
   - Add your OpenRouter API key in Constants.swift
   - Get your own GoogleServiceInfo.plist file from Firebase

3. Run the app:
   ```bash
   open ChatAI.xcodeproj 
   ```

---

## 📬 Feedback & Contributions

Found a bug? Have a feature request?
Feel free to [open an issue](https://github.com/adityaanand176/ChatAI/issues) or submit a PR.

---
