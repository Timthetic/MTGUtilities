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
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lifeLabel: UILabel!
    
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
        lifeLabel.font = lifeLabel.font.withSize(containerView.frame.height / 2)
    }
}
