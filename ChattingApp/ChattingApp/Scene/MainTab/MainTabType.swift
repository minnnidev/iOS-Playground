//
//  MainTabType.swift
//  ChattingApp
//
//  Created by 김민 on 6/23/24.
//

import Foundation

enum MainTabType: String, CaseIterable {
    case home
    case chat
    case phone

    var title: String {
        switch self {
        case .home:
            return "홈"
        case .chat:
            return "대화"
        case .phone:
            return "통화"
        }
    }

    func imageName(selected: Bool) -> String {
        selected ? "\(rawValue)_fill" : rawValue
    }
}
