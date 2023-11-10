import Combine
import SwiftUI
import Foundation
import UIKit

class FishStatus: ObservableObject {
    @Published var percentage = 0
}


class WaterViewModel: ObservableObject {
    @Published
    var waterAmount: Double = 150.0
    var waterTarget = 2000.0
    var waterLevel: CGFloat = 0
    
}

struct WavingBackground <Content: View>: View {
    private let content: Content
    private var fill: CGFloat = 0.0
    @State private var offsetY: CGFloat = 70
    @State private var offsetX: CGFloat = 0
    @State private var backgroundOffsetY: CGFloat = 75
    @State private var backgroundOffsetX: CGFloat = 70
    
    private var repeatingAnimation: Animation {
        Animation
            .easeInOut
            .speed(0.15)
            .repeatForever()
    }
    
    init(fill: CGFloat = .zero, @ViewBuilder content: () -> Content) {
        self.fill = fill
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            VStack {
                waves()
                fillingRectangle()
            }
            .offset(x: 0, y: 40)
            .foregroundColor(Color(red: 0, green: 0.58, blue: 0.980))
            .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
            content
        }
    }
}

extension WavingBackground {
    func waves() -> some View {
        ZStack {
            Wave(graphWidth: 1, amplitude: 0.05)
                .offset(x: offsetX, y: offsetY)
                .onAppear {
                    self.offsetY = 65
                    self.offsetX = -5
            }
            
            Wave(graphWidth: 1, amplitude: 0.05)
                 .opacity(0.7)
                 .offset(x: backgroundOffsetX, y: backgroundOffsetY)
                 .onAppear {
                    self.backgroundOffsetY = 70
                    self.backgroundOffsetX = 75
            }
        }
        .animation(repeatingAnimation)
        .frame(width: 200, height: 200)
    }
    
    func fillingRectangle() -> some View {
        Rectangle()
        .frame(width: 200, height: fill)
    }
}

struct Wave: Shape {
    let graphWidth: CGFloat
    let amplitude: CGFloat
    
    func path(in rect: CGRect) -> Path {
            let width = rect.width
            let height = rect.height

            let origin = CGPoint(x: 0, y: height * 0.50)

            var path = Path()
            path.move(to: origin)

            var endY: CGFloat = 0.0
            let step = 5.0
            for angle in stride(from: step, through: Double(width) * (step * step), by: step) {
                let x = origin.x + CGFloat(angle/360.0) * width * graphWidth
                let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi)) * height * amplitude
                path.addLine(to: CGPoint(x: x, y: y))
                endY = y
            }
            path.addLine(to: CGPoint(x: width, y: endY))
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: origin.y))

            return path
    }
}

struct WaterView: View {
    @ObservedObject var viewModel: WaterViewModel
    @ObservedObject var perc = FishStatus()
    @State private var showButton = false
    
    var body: some View {
        WavingBackground(fill: viewModel.waterLevel) {
            VStack {
                ZStack {
                    
                
                Button(action: {
                    
                    if (self.perc.percentage != 100) {
                        self.perc.percentage += 10
                        self.viewModel.waterLevel += 20
                    } else if (self.perc.percentage == 100) {
                        self.showButton = true
                        
                    }
                }, label: {
                        Text("\(self.perc.percentage)%")
                         .font(.system(size: 50, weight: .semibold, design: .rounded))
                    
                }).buttonStyle(PlainButtonStyle())
               NavigationLink(destination: CatchView()) {
               Text(" ")
                    .font(.system(size: 50, weight: .semibold, design: .rounded))
               .buttonStyle(PlainButtonStyle())
                .background(Color.clear)
                } .opacity(showButton ? 1 : 0)
                    
            }
                Text("Walk a bit more!")
                    .foregroundColor(.black)
                .font(.system(size: 16, weight: .regular, design: .rounded))
            }
        }
        
        .edgesIgnoringSafeArea(.all)
        
    }
}
    
    

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView(viewModel: WaterViewModel())
    }
}
