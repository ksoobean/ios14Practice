//
//  HeaderView.swift
//  ios14New
//
//  Created by master on 2020/11/11.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configureHeader() {
        titleLabel.text = "HEADER"
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.init(white: 0, alpha: 0.5).cgColor
    }
    
}
