//
// Inner Echo Launch Animation 2
// ContentView.swift
//
// Created by Reyna Myers on 2/11/24
//
// Copyright ©2024 DoorHinge Apps.
//


import SwiftUI
import BezelKit

struct ContentView: View {
    @State var animationPhase = 0
    
    @State var currentBezel = CGFloat.zero
    
    // These would be your app theme colors
    @State var appColor1 = "668DA1"
    @State var appColor2 = "6676A1"
    @State var appColor3 = "2D647F"
    
    @State var runTextAnimation = false
    
    @State var secondRectangleAnimate = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // This would be replaced with your home page view
                Image("Home Screenshot")
                    .resizable()
                
                // Hide the animation after it ends to prevent interference
                if animationPhase < 4 {
                    // This ZStack creates an inverse mask for the first rectangle - https://www.fivestars.blog/articles/reverse-masks-how-to/
                    ZStack {
                        // This rectangle appears later and just blurs the content below instead of covering it
                        Rectangle()
                            .fill(.ultraThinMaterial)
                        
                        // This inverse mask cutout animates slightly later than the second one
                        RoundedRectangle(cornerRadius: .deviceBezel)
                            .frame(width: animationPhase < 3 ? 0: geo.size.width, height: animationPhase < 3 ? 0: geo.size.height)
                            .blendMode(.destinationOut)
                        
                    }.compositingGroup()
                    
                    // This ZStack also creates an inverse mask
                    ZStack {
                        // Start with the same static background color as on the Launch Screen.storyboard
                        // Fade to a linear gradient background
                        // The first linear gradient has colors from the theme. The second one should be static like below.
                        Rectangle()
                            .fill(animationPhase > 0 ? LinearGradient(colors: [Color(hex: appColor1), Color(hex: appColor3)], startPoint: .top, endPoint: .bottom): LinearGradient(colors: [Color(hex: "668DA1")], startPoint: .top, endPoint: .bottom))
                        // You could replace the gradient with a material, but a fixed color is better because it adapts to screens better and can animate directly from the Launch Screen.storyboard
                        //.fill(.ultraThinMaterial)
                        
                        // This is the rectangle shape of the cutout section
                        RoundedRectangle(cornerRadius: .deviceBezel)
                            .frame(width: animationPhase < 2 ? 0: geo.size.width, height: animationPhase < 2 ? 0: geo.size.height)
                            .blendMode(.destinationOut)
                        
                    }.compositingGroup()
                    
                    // The animated text effect
                    AnimatedText(runAnimation: $runTextAnimation)
                }
            }
        }.ignoresSafeArea()
            .onAppear() {
                runAnimation()
            }
    }
    
    func runAnimation() {
        // Starts the animation for the text effect
        runTextAnimation = true
        
        // Keyframe system for animation - Increases animationPhase at set intervals
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 1.0)) {
                animationPhase = 1
            }
            
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.8) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    animationPhase = 2
                }
                
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2) {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        animationPhase = 3
                    }
                    
                    // Ends the animation
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.0) {
                        animationPhase = 4
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
