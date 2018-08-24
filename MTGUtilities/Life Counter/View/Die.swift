//
//  Die.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/23/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class Die: UIView {


    var value: Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath.init(roundedRect: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height), cornerRadius: CGFloat(5.0))
        UIColor.black.setFill()
        path.fill()
        makeDot(withCenter: CGPoint(x: frame.midX, y: frame.midY), andRadius: 5.0)
        
    }
    
    func makeDot(withCenter center: CGPoint, andRadius radius: CGFloat){
        let path = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
        UIColor.white.setFill()
        path.fill()
    }
    
    
}
