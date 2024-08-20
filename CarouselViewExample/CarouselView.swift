//
//  CarouselView.swift
//  CarouselViewExample
//
//  Created by kosha on 14.11.2023.
//

import SwiftUI

struct CarouselView: View {
    @State private var draggingItem = 0.0
    @Binding var selectedItem: Int
    
    private let pageInfo: [PageInfo] = PageInfo.pageInfo
    
    func color(for id: Int) -> Color {
        switch id {
        case 0: return .red
        case 1: return .blue
        case 2: return .green
        default: return .clear
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(pageInfo) { item in
                color(for: item.index)
                    .frame(width: 235, height: 360)
                    .padding(.vertical, 30)
                    .scaleEffect(1.0 - abs(distance(item.index)) * 0.2 )
                    .offset(x: myXOffset(item.index), y: 0)
                    .zIndex(1.0 - abs(distance(item.index)) * 0.1)
            }
        }
        .gesture(
            DragGesture()
            //speed
                .onChanged { value in
                    draggingItem = value.translation.width / 250
                    print("\(draggingItem)")
                }
                .onEnded { value in
                    withAnimation {
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(pageInfo.count))
                    } completion: {
                        var newSelected = selectedItem - Int(draggingItem)
                        if newSelected < 0 {
                            newSelected += pageInfo.count
                        }
                        if newSelected >= pageInfo.count {
                            newSelected -= pageInfo.count
                        }
                        selectedItem = newSelected
                        draggingItem = 0
                        print("\(draggingItem)")
                        print("new selected \(selectedItem)")

                    }
                }
        )
    }
    
    func distance(_ item: Int) -> Double {
        return (Double(item) - Double(selectedItem) + draggingItem).remainder(dividingBy: Double(pageInfo.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(pageInfo.count) * distance(item)
        return sin(angle) * 280
    }
}

#Preview {
    CarouselView(selectedItem: .constant(1))
}
