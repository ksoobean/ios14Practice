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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 테스트
        
        self.colorView.layer.cornerRadius = 5
        self.colorName.textColor = .white
        self.colorName.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    public func configureCell(cellVM: ColorVM) {
        self.colorView.backgroundColor = cellVM.color
        self.colorName.text = cellVM.colorName.uppercased()
    }
}
