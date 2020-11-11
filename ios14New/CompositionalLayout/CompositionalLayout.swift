//
//  ListCollectionViewController.swift
//  ios14New
//
//  Created by master on 2020/09/17.
//

import UIKit

class CompositionalLayout: CompositionalExtensionVC {

    @IBOutlet weak var containerStackView: UIStackView!
    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var thirdCollectionView: UICollectionView!
    
    let colorArray = ColorArray.makeColorData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerStackView.addArrangedSubview(self.makeFirstCollectionView())
        self.containerStackView.addArrangedSubview(self.makeSecondCollectionView())
        self.containerStackView.addArrangedSubview(self.makeThirdCollectionView())
        
        for subview in self.containerStackView.arrangedSubviews {
            if let collectionView: UICollectionView = subview as? UICollectionView {
                collectionView.register(UINib(nibName: "CompositionalLayoutCell", bundle: nil), forCellWithReuseIdentifier: "CompositionalLayoutCell")
                collectionView.dataSource = self
            }
        }
    }
    
    func makeFirstCollectionView() -> UICollectionView {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1/4)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize:.init(widthDimension: .fractionalWidth(1),
                                                                        heightDimension: .fractionalHeight(1)),
                                                       subitem: item, count: 4)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
//        section.orthogonalScrollingBehavior = .groupPaging
        firstCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout.init(section: section)
        return firstCollectionView
    }
    
    func makeSecondCollectionView() -> UICollectionView {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(1),
                                                                        heightDimension: .absolute(100)),
                                                       subitem: item, count: 4)
        group.interItemSpacing = .fixed(5)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        secondCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout.init(section: section)
        
        return secondCollectionView
    }
    
    func makeThirdCollectionView() -> UICollectionView {
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1)))
        
        let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)), subitem: trailingItem, count: 2)
        
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: [leadingItem, trailingGroup])
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 10, bottom: 5.0, trailing: 10)
        section.interGroupSpacing = 10
        
        thirdCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
        
        return thirdCollectionView
    }
}

// collectionview delegate, datasource
extension CompositionalLayout: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompositionalLayoutCell", for: indexPath) as! CompositionalLayoutCell
        
        cell.configureCell(cellVM: self.colorArray[indexPath.row])
        
        return cell
    }
    
    
}
