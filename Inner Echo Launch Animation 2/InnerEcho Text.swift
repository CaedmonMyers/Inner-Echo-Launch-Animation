import SwiftUI

// Animated text view
struct AnimatedText: View {
    @Binding var runAnimation: Bool
    
    @State private var animateEcho = false

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                ZStack {
                    ForEach(1..<5) { i in
                        Text("Inner Echo")
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .fontWeight(.bold)
                            .foregroundColor(.white.opacity(Double(5 - i) * 0.2))
                            .scaleEffect(animateEcho ? CGFloat(i) : 1)
                            .opacity(animateEcho ? 0 : 1)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                }
                .animation(Animation.easeOut(duration: 1.5).delay(0.5), value: animateEcho)

                Spacer()
            }
        }
        .onChange(of: runAnimation, {
            animateEcho = true
        })
    }
}



