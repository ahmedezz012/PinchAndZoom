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
    @State private var isDrawerOpen = false
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
    
    var mainImage: some View {
        Image(pages[currentIndex].image)
            .resizable()
            .aspectRatio(contentMode: .fit).cornerRadius(DrawingConstants.mediumRadius)
            .opacity(isAnimating ? 1.0 : 0)
            .offset(x: imageOffset.width, y: imageOffset.height)
            .scaleEffect(scaleEffect).onTapGesture(count: DrawingConstants.doubleTab) {
                onDoubleTab()
            }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                mainImage
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
                    withAnimation(.linear(duration: DrawingConstants.animationDuration)) {
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
        HStack(spacing: DrawingConstants.spacing_12) {
            openDrawerImage
            
            ForEach(pages) { page in
                thumbImage(page: page)
            }
            
            Spacer()
        }.padding(EdgeInsets().navigationDrawerPadding()).background(.ultraThinMaterial).cornerRadius(DrawingConstants.largeRadius).frame(width: DrawingConstants.navigationDrawerWidth).padding(.top, UIScreen.main.bounds.height / DrawingConstants.mediumPadding).offset(x: isDrawerOpen ? DrawingConstants.openOffset : DrawingConstants.closedOffset)
    }
    
    func thumbImage(page: Page) -> some View {
        return Image(page.thumb)
            .resizable().scaledToFit().frame(width: DrawingConstants.dimens_80).cornerRadius(DrawingConstants.mediumRadius).onTapGesture {
                withAnimation(.easeIn) {
                    isDrawerOpen.toggle()
                }
                currentIndex = page.id
            }
    }
    
    var openDrawerImage: some View {
        Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left").resizable().scaledToFit().frame(height: DrawingConstants.openDrawerImageHeight).padding(DrawingConstants.smallPadding).foregroundStyle(.secondary).onTapGesture{
            withAnimation(.easeIn) {
                isDrawerOpen.toggle()
            }}
    }
    
    var zoomInfoLayout: some View {
        InfoLayout(scale: scaleEffect, offset: imageOffset).padding(.horizontal).padding(.top, DrawingConstants.xxLargePadding)
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
            }.padding(EdgeInsets().zoomingButtonsPadding()).background(.ultraThinMaterial).cornerRadius(DrawingConstants.mediumRadius)
        }.padding(.bottom, DrawingConstants.xxLargePadding)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
