//
//  BackgroundView.swift
//  ios14New
//
//  Created by master on 2020/11/11.
//

import UIKit

class BackgroundView: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
    }
    
}
