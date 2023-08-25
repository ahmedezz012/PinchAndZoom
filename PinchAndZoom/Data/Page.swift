//
//  Page.swift
//  PinchAndZoom
//
//  Created by Ahmed Ezz on 26/08/2023.
//

import Foundation

struct Page : Identifiable{
    let id: Int
    let image: String
    var thumb: String {
        return "thumb-"+image
    }
}
