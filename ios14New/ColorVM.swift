//
//  ColorVM.swift
//  ios14New
//
//  Created by master on 2020/09/17.
//

import Foundation
import UIKit

class ColorVM: NSObject {
    
    var color: UIColor = .clear
    var colorName: String = ""
    
    public class func initVM(color: UIColor, colorName: String) -> ColorVM {
        let vm = ColorVM()
        
        vm.color = color
        vm.colorName = colorName
        
        return vm
    }
}

class ColorArray: NSObject {
    public class func makeColorData() -> [ColorVM] {
        return [
            ColorVM.initVM(color: .systemRed, colorName: "red"),
            ColorVM.initVM(color: .systemOrange, colorName: "orange"),
            ColorVM.initVM(color: .systemYellow, colorName: "yellow"),
            ColorVM.initVM(color: .systemGreen, colorName: "green"),
            ColorVM.initVM(color: .systemBlue, colorName: "blue"),
            ColorVM.initVM(color: .systemPurple, colorName: "purple"),
            ColorVM.initVM(color: .systemPink, colorName: "pink"),
            ColorVM.initVM(color: .systemTeal, colorName: "teal"),
            ColorVM.initVM(color: .systemGray, colorName: "gray"),
            ColorVM.initVM(color: .black, colorName: "black"),
            ColorVM.initVM(color: .cyan, colorName: "cyan"),
            ColorVM.initVM(color: .magenta, colorName: "magenta")
        ]
        
    }
}
