//
//  ManaView.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/5/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class ManaView: UIView {

    private var imageViews: [UIImageView]?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func add(image: UIImage) {
        var imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView
        imageViews?.append(imageView)
    }
    
    func clear(){
        
    }
    

}
