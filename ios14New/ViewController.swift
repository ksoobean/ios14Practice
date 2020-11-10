//
//  ViewController.swift
//  ios14New
//
//  Created by master on 2020/09/17.
//

import UIKit

class ViewController: UIViewController {

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
}

