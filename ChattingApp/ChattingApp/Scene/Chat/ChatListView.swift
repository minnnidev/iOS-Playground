//
//  ChatListView.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter

    @StateObject var viewModel: ChatListViewModel

    var body: some View {
        NavigationStack(path: $navigationRouter.destinations) {
            ScrollView {
                NavigationLink(value: NavigationDestination.search) {
                    SearchButton()
                }
                .padding(.vertical, 14)
                
                ForEach(viewModel.chatRooms, id: \.self) { chatRoom in
                    ChatRoomCell(chatRoom: chatRoom, userId: viewModel.userId)
                }
            }
            .navigationTitle("대화")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: NavigationDestination.self) {
                NavigationRoutingView(destination: $0)
            }
            .onAppear {
                viewModel.send(action: .load)
            }
        }
    }
}

fileprivate struct ChatRoomCell: View {
    let chatRoom: ChatRoom
    let userId: String

    var body: some View {
        NavigationLink(value: NavigationDestination.chat(
            chatroomId: chatRoom.chatRoomId,
            myUserId: userId,
            otherUserId: chatRoom.otherUserId)
        ) {
            HStack {
                Image("person")
                    .resizable()
                    .frame(width: 40, height: 40)

                VStack(alignment: .leading, spacing: 3) {
                    Text(chatRoom.otherUserName)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color.bkText)

                    if let lastMessage = chatRoom.lastMessage {
                        Text(lastMessage)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.greyDeep)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 17)
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static let container: DIContainer = .init(services: StubServices())
    static let navigationRouter: NavigationRouter = .init()

    static var previews: some View {
        ChatListView(viewModel: .init(container: Self.container, userId: "user1_id"))
            .environmentObject(Self.navigationRouter)
    }
}
