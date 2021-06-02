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
    
//    let colorArray = ColorArray.makeColorData()
    let sectionColorArray = [
        ColorArray.makeColorData(),
        ColorArray.makeColorData(),
        ColorArray.makeColorData(),
        ColorArray.makeColorData(),
        ColorArray.makeColorData()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        firstCollectionView.collectionViewLayout = self.makeFirstCollectionView()
        firstCollectionView.collectionViewLayout = self.testOrthogonalScroll()
        
        for subview in self.containerStackView.arrangedSubviews {
            if let collectionView: UICollectionView = subview as? UICollectionView {
                collectionView.register(UINib(nibName: "CompositionalLayoutCell", bundle: nil), forCellWithReuseIdentifier: "CompositionalLayoutCell")
                collectionView.dataSource = self
            }
        }
    }
    
    func makeFirstCollectionView() -> UICollectionViewCompositionalLayout {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        // 아이템 사이에 간격을 주는 방법 #1
//        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)), subitem: item, count: 4)
        
        // 아이템 사이에 간격을 주는 방법 #2
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        
        section.orthogonalScrollingBehavior = .none
        
        let layout = UICollectionViewCompositionalLayout.init(section: section)
        
        return layout
    }
    
    func testOrthogonalScroll() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0 :
                return self.makeSection(.continuous)
            case 1:
                return self.makeSection(.continuousGroupLeadingBoundary)
            case 2:
                return self.makeSection(.groupPaging)
            case 3:
                return self.makeSection(.groupPagingCentered)
            case 4:
                return self.makeSection(.paging)
            default: fatalError()
                
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 15
        layout.configuration = config
        
        return layout
    }
    
    private func makeSection(_ behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1/5)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        section.orthogonalScrollingBehavior = behavior
        
        return section
        
    }
    
//    func makeSecondCollectionView() -> UICollectionView {
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1),
//                                              heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(1),
//                                                                        heightDimension: .absolute(100)),
//                                                       subitem: item, count: 4)
//        group.interItemSpacing = .fixed(5)
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//
//        secondCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout.init(section: section)
//
//        return secondCollectionView
//    }
//
//    func makeThirdCollectionView() -> UICollectionView {
//        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1)))
//
//        let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
//        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)), subitem: trailingItem, count: 2)
//
//        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: [leadingItem, trailingGroup])
//
//        let section = NSCollectionLayoutSection(group: nestedGroup)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 10, bottom: 5.0, trailing: 10)
//        section.interGroupSpacing = 10
//
//        thirdCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
//
//        return thirdCollectionView
//    }
}

// collectionview delegate, datasource
extension CompositionalLayout: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return colorArray.count
        return self.sectionColorArray[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompositionalLayoutCell", for: indexPath) as! CompositionalLayoutCell
        
//        cell.configureCell(cellVM: self.colorArray[indexPath.row])
        cell.configureCell(cellVM: self.sectionColorArray[indexPath.section][indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionColorArray.count
    }
    
    
}
