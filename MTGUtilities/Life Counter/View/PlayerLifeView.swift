//
//  PlayerLifeView.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/20/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation
import UIKit

class PlayerLifeView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(editName(_:)))
            doubleTap.numberOfTapsRequired = 2
            nameLabel.addGestureRecognizer(doubleTap)
            
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(nameSingleTapped(_:)))
            singleTap.require(toFail: doubleTap)
            nameLabel.addGestureRecognizer(singleTap)
            
        }
    }
    @IBOutlet weak var minusLabel: UILabel!
    @IBOutlet weak var plusLabel: UILabel!
    
    var fillColor = UIColor.red.withAlphaComponent(0.5){
        didSet{
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    var strokeColor: UIColor?{
        didSet{
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    weak var delegate: PlayerLifeViewDelegate?
    
    @objc func editName(_ gestureRecognizer: UITapGestureRecognizer){
        
        delegate?.nameDoubleTapped(forPlayerLifeView: self)
        
    }
    @objc func nameSingleTapped(_ gestureRecognizer: UITapGestureRecognizer){
        delegate?.nameSingleTapped(forPlayerLifeView: self)
    }
    
    @IBAction func minusTapped(_ sender: Any) {
        delegate?.minusTapped(forPlayerLifeView: self)
    }
    
    @IBAction func plusTapped(_ sender: Any) {
        delegate?.plusTapped(forPlayerLifeView: self)
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("PlayerLifeView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let smallestSize = min(frame.height, frame.width)
        lifeLabel.font = lifeLabel.font.withSize(smallestSize / 2)
        minusLabel.font = minusLabel.font.withSize(smallestSize / 2)
        plusLabel.font = plusLabel.font.withSize(smallestSize / 2)
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath.init(
            roundedRect: CGRect(x: containerView.frame.width * BUFFER,
                                y: containerView.frame.height * BUFFER,
                                width: containerView.frame.width * (1-2*BUFFER) ,
                                height: containerView.frame.height * (1-2*BUFFER)), cornerRadius: 5)
        fillColor.setFill()
        roundedRect.fill()
        if let color = strokeColor{
            roundedRect.lineWidth = 5
            color.setStroke()
            roundedRect.stroke()
        }
    }
}

extension PlayerLifeView{
    var BUFFER: CGFloat {
        return 0.03
    }
    var CORNER_RADIUS: CGFloat{
        return 5
    }
}

protocol PlayerLifeViewDelegate: class {
    func minusTapped(forPlayerLifeView lifeView: PlayerLifeView)
    func plusTapped(forPlayerLifeView lifeView: PlayerLifeView)
    func nameSingleTapped(forPlayerLifeView lifeView: PlayerLifeView)
    func nameDoubleTapped(forPlayerLifeView lifeView: PlayerLifeView)
}

