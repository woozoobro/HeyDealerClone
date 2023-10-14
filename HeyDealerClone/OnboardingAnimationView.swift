//
//  OnboardingAnimationView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/14.
//

import SwiftUI

struct OnboardingAnimationView: View {
    var body: some View {
        ZStack {
            BubbleView()
                .blur(radius: 1)
            
            LicenseAnimation(title: "헤이딜러 짱짱", reverse: true)
                .scaleEffect(0.5)
                .offset(x: -70, y: 80)
                .blur(radius: 0.3)
            LicenseAnimation(title: "12가 3425", reverse: false)
                .scaleEffect(0.9)
        }
    }
}

struct LicenseObject: View {
    let title: String
    var body: some View {
        HStack {
            circle
            
            Text(title)
                .minimumScaleFactor(0.5)
                .foregroundStyle(.shadow(.inner(color: .white.opacity(0.5), radius: 1, x: 0.5, y: 0.5)))
                .customFont(fontWeight: .semiBold, size: 50)
                .shadow(color: .gray.opacity(0.6), radius: 1, x: 0, y: 0)
            
            circle
        }
        .padding(.horizontal, 20)
        .frame(height: 70)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.shadow(.inner(color: .gray.opacity(0.4), radius: 1, x: 1, y: 1)))
                .foregroundColor(.white)
                .padding(3)
                .background { RoundedRectangle(cornerRadius: 12) }
                .padding(3)
                .background {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.white)
                        .shadow(radius: 0.5)
                }
        }
    }
    
    private var circle: some View {
        Circle()
            .fill(.shadow(.inner(color: .white.opacity(0.1), radius: 0.5, x: -0.5, y: 1)))
            .shadow(color: .gray.opacity(0.4), radius: 0.8, x: 0, y: 1)
            .shadow(color: .gray.opacity(0.2), radius: 1, x: 1, y: 0.5)
            .foregroundColor(.white)
            .frame(width: 12)
    }
}

struct LicenseAnimation: View {
    @State private var progress: CGFloat = 0
    let title: String
    let reverse: Bool
    
    var body: some View {
        GeometryReader { geo in
            let diameter = geo.size.width / 24
            let radius = diameter / 2
            let angle = progress * .pi
            
            LicenseObject(title: title)
            .offset(x: 200)
            .rotation3DEffect(Angle(degrees: 0), axis: (x: 0, y: 0, z: 0))
            .position(
                x: radius * (1 - cos(angle)),
                y: geo.size.height / 2 - radius * sin(angle)
            )
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    if !reverse {
                        withAnimation {
                            progress += 0.05
                        }
                        if progress >= 2 {
                            progress = 0
                        }
                    } else {
                        withAnimation {
                            progress -= 0.05
                        }
                        if progress <= -2 {
                            progress = 0
                        }
                    }
                    
                }
            }
        }
        
    }
    
    private var circle: some View {
        Circle()
            .fill(.shadow(.inner(color: .white.opacity(0.1), radius: 0.5, x: -0.5, y: 1)))
            .shadow(color: .gray.opacity(0.4), radius: 0.8, x: 0, y: 1)
            .shadow(color: .gray.opacity(0.2), radius: 1, x: 1, y: 0.5)
            .foregroundColor(.white)
            .frame(width: 12)
    }
}

struct BubbleView: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            let angle = Angle.degrees(now.remainder(dividingBy: 12) * 15)
            let x = cos(angle.radians)
            let angle2 = Angle.degrees(now.remainder(dividingBy: 10) * 4)
            let x2 = cos(angle2.radians)
            
            Canvas { context, size in
                context.fill(
                    path(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), x: x, x2: x2),
                    with: .linearGradient(Gradient(colors: [.gray.opacity(0.1), .blue.opacity(0.05)]), startPoint: CGPoint(x: -100, y:-100), endPoint: CGPoint(x:300, y: 300)))
            }
            .frame(width: 300, height: 240)
        }
        
    }
    
    func path(in rect: CGRect, x: Double, x2: Double) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.993*width, y: 0.42593*height))
        path.addCurve(to: CGPoint(x: 0.6355*width*x2, y: height), control1: CGPoint(x: 0.92554*width*x2, y: 0.77749*height*x2), control2: CGPoint(x: 0.91864*width*x2, y: height))
        path.addCurve(to: CGPoint(x: 0.08995*width, y: 0.60171*height), control1: CGPoint(x: 0.35237*width*x, y: height), control2: CGPoint(x: 0.2695*width, y: 0.77304*height))
        path.addCurve(to: CGPoint(x: 0.34086*width, y: 0.06324*height*x), control1: CGPoint(x: -0.0896*width, y: 0.43038*height), control2: CGPoint(x: 0.00248*width, y: 0.23012*height*x))
        path.addCurve(to: CGPoint(x: 0.9923*width, y: 0.42593*height), control1: CGPoint(x: 0.67924*width, y: -0.10364*height*x), control2: CGPoint(x: 1.05906*width, y: 0.07436*height*x2))
        path.addCurve(to: CGPoint(x: 0.9923*width, y: 0.42593*height), control1: CGPoint(x: 0.67924*width, y: 0.20364*height*x), control2: CGPoint(x: 1.05906*width, y: 0.07436*height*x2))
        path.closeSubpath()
        return path
    }
}

struct OnboardingAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingAnimationView()
    }
}
