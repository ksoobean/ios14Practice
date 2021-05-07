//
//  ViewController.swift
//  ios14New
//
//  Created by master on 2020/09/17.
//

import UIKit
import Photos
import PhotosUI

class ViewController: UIViewController {
    
    var selecltImageList: [UIImage] = []
    
    var itemProviders: [NSItemProvider] = []
    var iterator: IndexingIterator<[NSItemProvider]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func goCompositionalLayout(_ sender: Any) {
        let listCollectionVC = CompositionalLayout.init(nibName: "CompositionalLayout", bundle: nil)
        self.present(listCollectionVC, animated: true, completion: nil)
    }
    
    @IBAction func goSecondCompositionalLayout(_ sender: Any) {
        let listCollectionVC = SecondCompositionalLayout.init(nibName: "SecondCompositionalLayout", bundle: nil)
        self.present(listCollectionVC, animated: true, completion: nil)
    }
    
    @IBAction func goThirdCompositionalLayout(_ sender: Any) {
        let listCollectionVC = ThirdCompositionalLayout.init(nibName: "ThirdCompositionalLayout", bundle: nil)
        self.present(listCollectionVC, animated: true, completion: nil)
    }
    
    @IBAction func imagePicker(_ sender: Any) {
        let pickerVC = ImagePickerViewController(nibName: "ImagePickerViewController", bundle: nil)
        pickerVC.modalPresentationStyle = .fullScreen
        self.present(pickerVC, animated: true, completion: nil)
        
    }
    
}
