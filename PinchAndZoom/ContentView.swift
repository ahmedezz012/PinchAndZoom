//
//  ContentView.swift
//  PinchAndZoom
//
//  Created by Ahmed Ezz on 20/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State var scaleEffect: CGFloat = DrawingConstants.normalScale
    @State private var isAnimating = false
    @State private var imageOffset : CGSize = .zero
    @State private var currentIndex = 0
    @State private var isDrawerOpen = true
    private var pages: [Page] = pagesData
    
    func scaleDown() {
        return withAnimation(.spring()) {
            if scaleEffect <= 1 {
                resetAllWithAnimation()
            } else
            {
                scaleEffect -= 1
            }
        }
    }
    
    func scaleUp() {
        return withAnimation(.spring()) {
            if scaleEffect >= DrawingConstants.largeScale {
                scaleEffect = DrawingConstants.largeScale
            } else
            {
                scaleEffect += 1
            }
        }
    }
    
    func resetImageScale() {
        scaleEffect = DrawingConstants.normalScale
    }
    
    func resetImageOffset() {
        imageOffset = .zero
    }
    
    func resetAll() {
        resetImageScale()
        resetImageOffset()
    }
    
    func resetAllWithAnimation() {
        return withAnimation(.linear(duration: DrawingConstants.animationDuration)) {
            resetImageScale()
            resetImageOffset()
        }
    }
    
    func resetImageScaleWithAnimation() {
        return withAnimation(.linear(duration: DrawingConstants.animationDuration)) {
            resetImageScale()
        }
    }
    
    func resetImageOffsetWithAnimation() {
        return withAnimation(.linear(duration: DrawingConstants.animationDuration)) {
            resetImageOffset()
        }
    }
    
    func scaleToMax() {
        return withAnimation(.spring()) {
            scaleEffect = DrawingConstants.largeScale
        }
    }
    
    func onDoubleTab() {
        if(scaleEffect == DrawingConstants.normalScale)
        {
            scaleToMax()
        } else {
            resetAllWithAnimation()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                Image(pages[currentIndex].image)
                    .resizable()
                    .aspectRatio(contentMode: .fit).cornerRadius(DrawingConstants.mediumRadius)
                    .opacity(isAnimating ? 1.0 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(scaleEffect).onTapGesture(count: 2) {
                        onDoubleTab()
                    }
                    .gesture(DragGesture().onChanged {
                        value in
                        imageOffset = value.translation
                    }.onEnded { _ in
                        if scaleEffect <= DrawingConstants.normalScale {
                            resetAllWithAnimation()
                        }
                    })
            }.navigationTitle("Pinch and zoom").navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    withAnimation(.linear(duration: 1)) {
                        isAnimating = true
                    }
                }.padding()
                .overlay(zoomInfoLayout,alignment: .top)
                .overlay(
                    zoomingButtons, alignment: .bottom)
                .overlay(navigationDrawer,alignment: .topTrailing)
        }.navigationViewStyle(.stack)
    }
    
    var navigationDrawer: some View {
        HStack(spacing:12) {
            Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left").resizable().scaledToFit().frame(height: 40).padding(8).foregroundStyle(.secondary).onTapGesture{
                withAnimation(.easeIn) {
                    isDrawerOpen.toggle()
                }}
            
            ForEach(pages) { page in
                Image(page.thumb)
                    .resizable().scaledToFit().frame(width: 80).cornerRadius(DrawingConstants.mediumRadius).onTapGesture {
                        withAnimation(.easeIn) {
                            isDrawerOpen.toggle()
                        }
                        currentIndex = page.id
                    }
            }
            Spacer()
        }.padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)).background(.ultraThinMaterial).cornerRadius(DrawingConstants.largeRadius).frame(width: 260).padding(.top, UIScreen.main.bounds.height / 12).offset(x: isDrawerOpen ? 20 : 215)
    }
    var zoomInfoLayout: some View {
        InfoLayout(scale: scaleEffect, offset: imageOffset).padding(.horizontal).padding(.top,30)
    }
    var zoomingButtons: some View {
        Group {
            HStack{
                ZoomButton(action: {
                    scaleDown()
                }, imageName: "minus.magnifyingglass")
                ZoomButton(action: {
                    resetAllWithAnimation()
                }, imageName: "1.magnifyingglass")
                ZoomButton(action: {
                    scaleUp()
                }, imageName: "plus.magnifyingglass")
            }.padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)).background(.ultraThinMaterial).cornerRadius(DrawingConstants.mediumRadius)
        }.padding(.bottom, 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
