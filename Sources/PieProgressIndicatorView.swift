import SwiftUI

// mimics Things 3 progress pie
public struct PieProgressIndicatorView: View {
    // clamped between 0.0 - 1.0
    public var progress: Double
    
    // styling
    public var themeColor: Color = .blue
    public var ringWidth: CGFloat = 3
    public var gap: CGFloat = 3
    
    // DO NOT FORGET
    public init(progress: Double, themeColor: Color = .blue, ringWidth: CGFloat = 3, gap: CGFloat = 3) {
            self.progress = progress
            self.themeColor = themeColor
            self.ringWidth = ringWidth
            self.gap = gap
    }
    
    public var body: some View {
        GeometryReader { geometry in // ensures correct scaling within frame
            ZStack {
                Circle()
                    .stroke(themeColor, lineWidth: ringWidth)

                PieShape(progress: min(max(progress, 0), 1))
                    .fill(themeColor)
                    .padding(ringWidth + gap)
            }
        }
        // forces view to remain a perfect square/circle
        .aspectRatio(1, contentMode: .fit)
    }
}

// custom pie shape drawing clockwise
public struct PieShape: Shape {
    public var progress: Double
    
    // conforming to protocol to smoothly animate changes of progress value
    public var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        if progress <= 0 { return path }
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        // swiftui has 0 degrees at 3:00
        let startAngle = Angle(degrees: -90)
        let endAngle = Angle(degrees: -90 + (progress * 360))
        
        path.move(to: center)
        
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false) // because swiftui thinks in top-left to right rendering, so y-axis positives point downwards
        
        path.closeSubpath()
        
        return path
    }
}
