//
//  CornerRadius.swift
//  
//
//  Created by Justin Honda on 10/18/19.
//

import SwiftUI

struct CornerRadius : Shape {
    
    private var topLeft: CGFloat = 0.0
    private var topRight: CGFloat = 0.0
    private var bottomRight: CGFloat = 0.0
    private var bottomLeft: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        // Create new path
        var path = Path()
        
        // Get width and height from shape
        var width = rect.size.width
        var height = rect.size.height
        
        // Ensure radius is not greater than the smallest side
        let topLeft = min(min(self.topLeft, width / 2), height / 2)
        let topRight = min(min(self.topRight, width / 2), height / 2)
        let bottomRight = min(min(self.bottomRight, width / 2), height / 2)
        let bottomLeft = min(min(self.bottomLeft, width / 2), height / 2)
        
        // Begin drawing shape by starting at coordinate (x: width/2, y: 0). Default (0,0) coordinate is top right corner.
        path.move(to: CGPoint(x: width / 2, y: 0))
        
        
        
        
        
        return path
        
    }
}
