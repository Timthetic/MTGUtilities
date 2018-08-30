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
        value = Int(arc4random()) % 6 + 1
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        value = Int(arc4random()) % 6 + 1
        super.init(frame: frame)
    }
    
    init(withSideLength side: CGFloat, x: CGFloat, y: CGFloat){
        value = Int(arc4random()) % 6 + 1
        super.init(frame: CGRect(x: x, y: y, width: side, height: side))
    }
    
    
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath.init(roundedRect: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height), cornerRadius: CGFloat(10.0))
        UIColor.black.setFill()
        path.fill()
        
        let h = frame.height
        let w = frame.width
        switch value{
        case 1:
            makeDot(withXPos: 1/2 * w, andYPos: 1/2 * h, andRadius: 5)
        case 2:
            makeDot(withXPos: 1/6 * w, andYPos: 1/6 * h, andRadius: 5)
            makeDot(withXPos: 5/6 * w, andYPos: 5/6 * h, andRadius: 5)
        case 3:
            makeDot(withXPos: 1/6 * w, andYPos: 1/6 * h, andRadius: 5)
            makeDot(withXPos: 5/6 * w, andYPos: 5/6 * h, andRadius: 5)
            makeDot(withXPos: 1/2 * w, andYPos: 1/2 * h, andRadius: 5)
        case 4:
            makeDot(withXPos: 1/6 * w, andYPos: 1/6 * h, andRadius: 5)
            makeDot(withXPos: 5/6 * w, andYPos: 5/6 * h, andRadius: 5)
            makeDot(withXPos: 1/6 * w, andYPos: 5/6 * h, andRadius: 5)
            makeDot(withXPos: 5/6 * w, andYPos: 1/6 * h, andRadius: 5)
        case 5:
            makeDot(withXPos: 1/6 * w, andYPos: 1/6 * h, andRadius: 5)
            makeDot(withXPos: 5/6 * w, andYPos: 5/6 * h, andRadius: 5)
            makeDot(withXPos: 1/6 * w, andYPos: 5/6 * h, andRadius: 5)
            makeDot(withXPos: 5/6 * w, andYPos: 1/6 * h, andRadius: 5)
            makeDot(withXPos: 1/2 * w, andYPos: 1/2 * h, andRadius: 5)
        case 6:
            makeDot(withXPos: 1/6 * w, andYPos: 1/6 * h, andRadius: 5)
            makeDot(withXPos: 5/6 * w, andYPos: 5/6 * h, andRadius: 5)
            makeDot(withXPos: 1/6 * w, andYPos: 5/6 * h, andRadius: 5)
            makeDot(withXPos: 5/6 * w, andYPos: 1/6 * h, andRadius: 5)
            makeDot(withXPos: 1/6 * w, andYPos: 1/2 * h, andRadius: 5)
            makeDot(withXPos: 5/6 * w, andYPos: 1/2 * h, andRadius: 5)
        default:
            break
        }
        
    }
    
    func makeDot(withCenter center: CGPoint, andRadius radius: CGFloat){
        let path = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        UIColor.white.setFill()
        path.fill()
    }
    func makeDot(withXPos x: CGFloat, andYPos y: CGFloat, andRadius radius: CGFloat){
        makeDot(withCenter: CGPoint(x: x, y: y), andRadius: radius)
    }
    
    
}
