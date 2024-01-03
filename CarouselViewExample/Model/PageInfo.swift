//
//  PageInfo.swift
//  CarouselViewExample
//
//  Created by kosha on 14.11.2023.
//

import Foundation

struct PageInfo: Identifiable {
    let id = UUID().uuidString
    let index: Int
    let title: String
    let description: String
}

extension PageInfo {
    static var pageInfo: [PageInfo] {
        [PageInfo(index: 0,
                  title: "Title 1",
                  description: "First view description"),
         PageInfo(index: 1,
                  title: "Title 1",
                  description: "Second view description."),
         PageInfo(index: 2,
                  title: "Title 2",
                  description: "Third view description.")]
    }
}
