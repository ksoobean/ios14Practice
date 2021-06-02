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
//        self.imageView.image = vm.imageData
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .fast
        
        PHImageManager().requestImage(for: vm.asset, targetSize: self.imageView.bounds.size, contentMode: .aspectFit, options: options) { (image, info) in
            guard let image = image else { return }
            self.imageView.image = image

        }
        
    }
    
}
