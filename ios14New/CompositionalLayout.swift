//
//  ListCollectionViewController.swift
//  ios14New
//
//  Created by master on 2020/09/17.
//

import UIKit

class CompositionalLayout: UIViewController {

    @IBOutlet weak var containerStackView: UIStackView!
    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    let colorArray = ColorArray.makeColorData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerStackView.addArrangedSubview(self.makeFirstCollectionView())
        self.containerStackView.addArrangedSubview(self.makeSecondCollectionView())
        
        for subview in self.containerStackView.arrangedSubviews {
            if let collectionView: UICollectionView = subview as? UICollectionView {
                collectionView.register(UINib(nibName: "CompositionalLayoutCell", bundle: nil), forCellWithReuseIdentifier: "CompositionalLayoutCell")
                collectionView.delegate = self
                collectionView.dataSource = self
            }
        }
    }
    
    func makeFirstCollectionView() -> UICollectionView {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1/4))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.vertical(layoutSize:.init(widthDimension: .fractionalWidth(1),
                                                                        heightDimension: .fractionalHeight(1)),
                                                       subitem: item, count: 4)
        let section = NSCollectionLayoutSection(group: group)
        
//        section.orthogonalScrollingBehavior = .groupPaging
        firstCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout.init(section: section)
        firstCollectionView.isPagingEnabled = true
        
        
        
        return firstCollectionView
    }
    
    func makeSecondCollectionView() -> UICollectionView {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(1),
                                                                        heightDimension: .absolute(100)),
                                                       subitem: item, count: 4)
        group.interItemSpacing = .fixed(5)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        secondCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout.init(section: section)
        
        return secondCollectionView
    }
}

// collectionview delegate, datasource
extension CompositionalLayout: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompositionalLayoutCell", for: indexPath) as! CompositionalLayoutCell
        
        cell.configureCell(cellVM: self.colorArray[indexPath.row])
        
        return cell
    }
    
    
}
