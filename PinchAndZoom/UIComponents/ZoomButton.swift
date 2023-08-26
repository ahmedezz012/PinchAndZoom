//
//  ZoomButton.swift
//  PinchAndZoom
//
//  Created by Ahmed Ezz on 24/08/2023.
//

import SwiftUI

struct ZoomButton: View {
    var action: () -> Void
    var imageName: String
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageName)
        }
    }
}

struct ZoomButton_Previews: PreviewProvider {
    static var previews: some View {
        ZoomButton(action: { }, imageName: "plus.magnifyingglass").previewLayout(.sizeThatFits)
    }
}
