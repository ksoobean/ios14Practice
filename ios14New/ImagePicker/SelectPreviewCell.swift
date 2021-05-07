//
//  SelectPreviewCell.swift
//  ios14New
//
//  Created by master on 2021/05/04.
//

import UIKit
import Photos

class SelectPreviewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageView.contentMode = .scaleToFill
    }
    
    public func configureCell(vm: ImagePickerVM) {
        self.imageView.image = vm.imageData
    }
    
}
