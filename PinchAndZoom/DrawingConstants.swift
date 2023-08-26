//
//  DrawingConstants.swift
//  PinchAndZoom
//
//  Created by Ahmed Ezz on 20/08/2023.
//

import Foundation
import SwiftUI


class DrawingConstants {
    static let mediumRadius : CGFloat = 10
    static let largeRadius : CGFloat = 12
    static let normalScale = 1.0
    static let largeScale = 10.0
    static let animationDuration : Double = 1
    
    static let smallPadding = 8.0
    static let mediumPadding = 12.0
    static let largePadding = 16.0
    static let xLargePadding = 20.0
    static let xxLargePadding = 30.0
    static let openDrawerImageHeight : CGFloat = 40
    static let doubleTab = 2
    static let dimens_30 : CGFloat = 30
    static let dimens_80 : CGFloat = 80
    static let spacing_2 : CGFloat = 2
    static let spacing_12 : CGFloat = 12
    static let longPressDuration : CGFloat = 1
    static let navigationDrawerWidth = 260.0
    static let closedOffset = 215.0
    static let openOffset = 20.0
}

extension EdgeInsets {
    
    func navigationDrawerPadding() -> EdgeInsets {
        return  EdgeInsets(top: DrawingConstants.largePadding, leading: DrawingConstants.smallPadding, bottom: DrawingConstants.largePadding, trailing: DrawingConstants.smallPadding)
    }
    
    func zoomingButtonsPadding() -> EdgeInsets {
        return EdgeInsets(top: DrawingConstants.mediumPadding, leading: DrawingConstants.xLargePadding, bottom: DrawingConstants.mediumPadding, trailing: DrawingConstants.xLargePadding)
    }
    
}
