//
//  TitleView.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 12/10/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

@IBDesignable
class TitleView: UIView {
    
    private var titleLabel = UILabel()
    
    // MARK: - Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        titleLabel.frame = CGRect(x: 30, y: 30, width: 300, height: 50)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    // MARK: - Inspectable Properties
    
    @IBInspectable
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
}
