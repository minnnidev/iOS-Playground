//
//  PhotoImage.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import SwiftUI

struct PhotoImage: Transferable {

    let data: Data

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw PhotoPickerError.importFailed
            }

            guard let data = uiImage.jpegData(compressionQuality: 0.3) else {
                throw PhotoPickerError.importFailed
            }

            return PhotoImage(data: data)
        }
    }
}
