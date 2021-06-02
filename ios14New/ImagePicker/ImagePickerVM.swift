//
//  ImagePickerVM.swift
//  ios14New
//
//  Created by master on 2021/05/07.
//

import Foundation
import UIKit
import Photos


struct ImagePickerVM {
    var imageData: UIImage?
    var asset: PHAsset
    var isSelected: Bool = false
    var index: Int = -1
}

