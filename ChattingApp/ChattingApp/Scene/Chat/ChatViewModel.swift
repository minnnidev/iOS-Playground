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
        
    }
}
