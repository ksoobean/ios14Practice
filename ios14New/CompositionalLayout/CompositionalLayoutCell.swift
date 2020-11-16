//
//  CompositionalLayoutCell.swift
//  ios14New
//
//  Created by master on 2020/09/17.
//

import UIKit

class CompositionalLayoutCell: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorName: UILabel!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.colorView.layer.cornerRadius = 5
        self.colorName.textColor = .white
        self.colorName.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    public func configureCell(cellVM: ColorVM) {
        self.colorView.backgroundColor = cellVM.color
        self.colorName.text = cellVM.colorName.uppercased()
    }
    
    public func configureRandomHeightCell(cellVM: ColorVM) {
        self.colorView.backgroundColor = cellVM.color
        self.colorName.text = cellVM.colorName.uppercased()
        
        self.viewHeight.constant = CGFloat.random(in: 100...200)
    }
}
