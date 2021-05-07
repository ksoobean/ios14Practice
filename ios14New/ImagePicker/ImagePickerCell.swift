//
//  ImagePickerCell.swift
//  ios14New
//
//  Created by master on 2021/05/04.
//

import UIKit
import Photos

class ImagePickerCell: UICollectionViewCell {

    var selectHandler: (() -> Void)?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageView.contentMode = .scaleToFill
        self.selectButton.setTitle("", for: .normal)
    }
    
    public func configureCell(vm: ImagePickerVM) {
        self.imageView.image = vm.imageData
        
        if true == vm.isSelected {
            self.selectButton.setTitle("\(vm.index + 1)", for: .normal)
            self.selectButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        } else {
            self.selectButton.setTitle("", for: .normal)
            self.selectButton.setImage(nil, for: .normal)
        }
    }
    
    

    @IBAction func selectImage(_ sender: Any) {
        self.selectHandler?()
    }
}
