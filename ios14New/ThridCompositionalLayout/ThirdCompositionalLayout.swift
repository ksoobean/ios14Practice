//
//  ThirdCompositionalLayout.swift
//  ios14New
//
//  Created by master on 2020/11/10.
//

import UIKit

class ThirdCompositionalLayout: CompositionalExtensionVC {

    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    let colorArray = ColorArray.makeColorSectionData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.firstCollectionView.dataSource = self
        self.firstCollectionView.register(UINib(nibName: "CompositionalLayoutCell", bundle: nil), forCellWithReuseIdentifier: "CompositionalLayoutCell")
        self.firstCollectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        
        self.firstCollectionView.collectionViewLayout = self.makeFirstCollectionViewLayout()
        
    }
    
    private func makeFirstCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        // 1
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0 :
                return self.makeFirstSection()
            case 1:
                return self.makeSecondSection()
            default: fatalError()
                
            }
        }
                
        // 3
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 60
        layout.configuration = config
        
        // 배경
        layout.register(UINib(nibName: "BackgroundView", bundle: nil), forDecorationViewOfKind: "background")
        
        return layout
    }
    
}

// Section , Header 만들기
extension ThirdCompositionalLayout {
    
    private func makeFirstSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(1),
                                                                        heightDimension: .estimated(100)),
                                                       subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.boundarySupplementaryItems = [self.createSectionHeader()]
        section.decorationItems = [self.createSectionBackground()]
        return section
    }
    
    private func makeSecondSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1/3)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize:.init(widthDimension: .fractionalWidth(1),
                                                                      heightDimension: .estimated(100)),
                                                       subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [self.createSectionHeader()]
        section.decorationItems = [self.createSectionBackground()]
        
        return section
    }
    
    /// 헤더 만들기
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return headerElement
    }
    
    /// 배경 만들기
    private func createSectionBackground() -> NSCollectionLayoutDecorationItem {
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        return backgroundItem
    }
}

// collectionview delegate, datasource
extension ThirdCompositionalLayout: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompositionalLayoutCell", for: indexPath) as! CompositionalLayoutCell
        
        cell.configureCell(cellVM: self.colorArray[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return colorArray.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
            fatalError("Could not dequeue SectionHeader")
        }
        headerView.configureHeader()
        return headerView
    }
    
}
