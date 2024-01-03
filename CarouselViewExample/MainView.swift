//
//  MainView.swift
//  CarouselViewExample
//
//  Created by kosha on 14.11.2023.
//

import SwiftUI

struct MainView: View {
    @State private var index: Int = 0

    private let pageInfo: [PageInfo] = PageInfo.pageInfo
    
    @State private var offset: CGFloat = 0
    @State private var isUserSwiping: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CarouselView(selectedItem: $index)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(self.pageInfo) { viewData in
                            VStack(alignment: .center, spacing: 0) {
                                Text(viewData.title)
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.blue)
                                    .padding(.bottom, 30)
                                Text(viewData.description)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 275, height: 42)
                                    .lineSpacing(3)
                            }
                                .frame(width: geometry.size.width)
                        }
                    }
                }
                .content
                .offset(x: self.isUserSwiping ? self.offset : CGFloat(self.index) * -geometry.size.width)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.isUserSwiping = true
                            self.offset = value.translation.width + -geometry.size.width * CGFloat(self.index)
                        })
                        .onEnded({ value in
                            if value.predictedEndTranslation.width < geometry.size.width / 2, self.index < self.pageInfo.count - 1 {
                                self.index += 1
                            }
                            if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                                self.index -= 1
                            }
                            withAnimation {
                                self.isUserSwiping = false
                            }
                        })
                )
                Spacer()
                HStack(spacing: 8) {
                    ForEach(0..<self.pageInfo.count, id: \.self) { index in
                        Button(action: circleButtonAction,
                               label: {
                            Circle()
                                .frame(width: 9, height: 9)
                                .foregroundStyle(index == self.index ? .blue : .gray.opacity(0.5))
                        }).buttonStyle(.borderless)
                    }
                }
                Spacer()
            }
        }
    }
    
    private func circleButtonAction() {
        withAnimation {
            self.index = index
        }
    }
}

#Preview {
    MainView()
}
