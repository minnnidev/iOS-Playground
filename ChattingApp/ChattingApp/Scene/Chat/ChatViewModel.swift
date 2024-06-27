//
//  ChatViewModel.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {

    enum Action {
        case load
        case addChat(String)
    }

    @Published var chatDataList: [ChatData] = []
    @Published var myUser: User?
    @Published var otherUser: User?
    @Published var message: String = ""

    private let chatRoomId: String
    private let myUserId: String
    private let otherUserId: String

    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()

    init(container: DIContainer, chatRoomId: String, myUserId: String, otherUserId: String) {
        self.container = container
        self.chatRoomId = chatRoomId
        self.myUserId = myUserId
        self.otherUserId = otherUserId 
    }

    func updateChatDataList(_ chat: Chat) {
        let key = chat.date.toChatDateKey

        if let index = chatDataList.firstIndex(where: { $0.dataStr == key }) {
            chatDataList[index].chats.append(chat)
        } else {
            let newChatData: ChatData = .init(dataStr: key, chats: [chat])
            chatDataList.append(newChatData)
        }
    }

    func getDirection(id: String) -> ChatItemDirection {
        return myUserId == id ? .right : .left
    }

    func send(action: Action) {
        switch action {
        case .load:
            Publishers.Zip(
                container.services.userService.getUser(userId: myUserId),
                container.services.userService.getUser(userId: otherUserId)
            )
            .sink { completion in
                // TODO: 
            } receiveValue: { [weak self] myUser, otherUser in
                self?.myUser = myUser
                self?.otherUser = otherUser
            }
            .store(in: &subscriptions)
        case let .addChat(message):
            let chat: Chat = .init(chatId: UUID().uuidString, userId: myUserId, message: message, date: Date())
            container.services.chatService.addChat(chat, to: chatRoomId)
                .sink { completion in

                } receiveValue: { [weak self] _ in
                    self?.message = ""
                }
                .store(in: &subscriptions)
        }
    }
}
