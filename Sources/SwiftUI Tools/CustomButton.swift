//
//  CustomButton.swift
//
//  Created by Justin Honda on 10/18/19.
//  Copyright © 2019 Justin Honda. All rights reserved.
//

import SwiftUI

public struct CustomButton: View {
    
    @State private var scale: CGFloat = 1.0
    @Binding var width: CGFloat
    @Binding var height: CGFloat
    @Binding var tLeft: CGFloat
    @Binding var tRight: CGFloat
    @Binding var bRight: CGFloat
    @Binding var bLeft: CGFloat
    @Binding var backgroundColor: Color
    
    public var body: some View {
        
        VStack {
            
            Path { path in
                
                /// Get Height and Width of button
                let width = self.width
                let height = self.height
                
                /// Ensure desired corner radius is not bigger than half of smallest side
                let tLeft = min(min(self.tLeft, width / 2), height / 2)
                let tRight = min(min(self.tRight, width / 2), height / 2)
                let bRight = min(min(self.bRight, width / 2), height / 2)
                let bLeft = min(min(self.bLeft, width / 2), height / 2)
                
                /// Start drawing path
                path.move(to: CGPoint(x: width / 2.0, y: 0))
                path.addLine(to: CGPoint(x: width - tRight, y: 0))
                path.addArc(center: CGPoint(x: width - tRight, y: tRight), radius: tRight, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                
                path.addLine(to: CGPoint(x: width, y: height - bRight))
                path.addArc(center: CGPoint(x: width - bRight, y: height - bRight), radius: bRight, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                
                path.addLine(to: CGPoint(x: bLeft, y: height))
                path.addArc(center: CGPoint(x: bLeft, y: height - bLeft), radius: bLeft, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                
                path.addLine(to: CGPoint(x: 0, y: tLeft))
                path.addArc(center: CGPoint(x: tLeft, y: tLeft), radius: tLeft, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                
                /// Path closes automatically
            }
            .fill(backgroundColor.opacity(Double(scale < 1 ? scale - 0.2 : 1)))
            .scaleEffect(scale)
            .onLongPressGesture(minimumDuration: 1, maximumDistance: 25, pressing: { (pressing) in
                // TODO: - maximumDistance needs to be at least width of button
                //       - minimumDuration is the minimum amount of time the user needs to hold the button to perform the action or else the action will not be performed
                if pressing {
                    print("pressing")
                    let animation = Animation.easeOut(duration: 0.1)
                    DispatchQueue.main.async {
                        withAnimation(animation) {
                            self.scale -=  0.1
                        }
                    }
                } else {
                    print("not pressing")
                    let animation = Animation.easeOut(duration: 0.1)
                    DispatchQueue.main.async {
                        withAnimation(animation) {
                            self.scale +=  0.1
                        }
                    }
                }
            }) {
                // Perform action only when minimumDuration has been met
                print("Perform action")
            }
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        
        GeometryReader { geometry in
            
            CustomButton(width: .constant(geometry.size.width), height: .constant(geometry.size.height / 4), tLeft: .constant(60), tRight: .constant(60), bRight: .constant(60), bLeft: .constant(60), backgroundColor: .constant(Color.blue))
                .frame(width: geometry.size.width, height: geometry.size.height / 4)
                .overlay(Text("Button")) // TODO: - Implement opacity
            
        }
    }
}
