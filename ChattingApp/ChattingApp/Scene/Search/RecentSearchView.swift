//
//  RecentSearchView.swift
//  ChattingApp
//
//  Created by 김민 on 6/28/24.
//

import SwiftUI

struct RecentSearchView: View {
    @Environment(\.managedObjectContext) var objectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var results: FetchedResults<SearchResult>

    var body: some View {
        VStack(spacing: 0) {
            titleView
                .padding(.bottom, 20)

            if results.isEmpty {
                Text("검색 내역이 없습니다.")
                    .font(.system(size: 10))
                    .foregroundColor(.greyDeep)
                    .padding(.vertical, 54)
                Spacer()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(results, id: \.self) { result in
                            HStack {
                                Text(result.name ?? "")
                                    .font(.system(size: 14))
                                    .foregroundColor(.bkText)

                                Spacer()

                                Button {
                                    objectContext.delete(result)
                                    try? objectContext.save()
                                } label: {
                                    Image("close_search", label: Text("검색어 삭제"))
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                }
                            }
                            .accessibilityElement(children: .combine)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 30)
    }

    var titleView: some View {
        HStack {
            Text("최근 검색어")
                .font(.system(size: 10, weight: .bold))
            Spacer()
        }
        .accessibilityAddTraits(.isHeader)
    }
}

#Preview {
    RecentSearchView()
}
