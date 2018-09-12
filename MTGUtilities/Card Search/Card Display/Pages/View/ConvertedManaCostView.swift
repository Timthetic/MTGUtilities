//
//  NumberView.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/6/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

///This entire thing is just a number with an arc around it showing how big it is
@IBDesignable
class ConvertedManaCostView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var cmcLabel: UILabel!{
        didSet{
            cmcLabel.text = "fsajld"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    
    @IBInspectable var value: Int = 0
        {
        didSet{
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    @IBInspectable var topValue: Int = 10
        {
        didSet{
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    @IBInspectable var color: UIColor = UIColor.black
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        view.isOpaque = false
        view.backgroundColor = .clear
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ConvertedManaCostView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

    override func layoutSubviews(){
        super.layoutSubviews()
        cmcLabel.text = "\(value)"
    }
    
    //Draw an arc that is longer for bigger numbers
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let cappedValue = min(value, topValue)
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                    radius: bounds.height / CGFloat(2.5),
                    startAngle: CGFloat(3.0) * CGFloat.pi / CGFloat(2.0),
                    endAngle: CGFloat.pi * (1.5 + 2.0 * (CGFloat(cappedValue) / CGFloat(topValue))),
                    clockwise: true)
        color.setStroke()
        path.lineWidth = 5
        path.stroke()
    }

}
