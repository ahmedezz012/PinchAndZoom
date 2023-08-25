//
//  InfoLayout.swift
//  PinchAndZoom
//
//  Created by Ahmed Ezz on 20/08/2023.
//

import SwiftUI

struct InfoLayout: View {
    var scale: CGFloat
    var offset: CGSize
    @State private var shouldShowInfo : Bool = false
    var body: some View {
        HStack {
            Image(systemName: "circle.circle").symbolRenderingMode(.hierarchical).resizable().frame(width: 30,height: 30).onLongPressGesture(minimumDuration: 1) {
                withAnimation(.easeOut) {
                    shouldShowInfo.toggle()
                }
            }
            Spacer()
            HStack(spacing: 2) {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                Spacer()
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
                Spacer()
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
            }.font(.footnote).padding(8)
                .background(.ultraThinMaterial)
                .cornerRadius(8).opacity(shouldShowInfo ? 1 : 0)
        }
                                            
    }
}

struct InfoLayout_Previews: PreviewProvider {
    static var previews: some View {
        InfoLayout(scale: 1,offset: .zero).previewLayout(.sizeThatFits).preferredColorScheme(.dark)
    }
}
