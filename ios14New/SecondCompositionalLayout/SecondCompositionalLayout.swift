//
//  SecondCompositionalLayout.swift
//  ios14New
//
//  Created by master on 2020/11/09.
//

import UIKit

class SecondCompositionalLayout: CompositionalExtensionVC {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    let colorArray = ColorArray.makeColorData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CompositionalLayoutCell", bundle: nil), forCellWithReuseIdentifier: "CompositionalLayoutCell")
        
        self.collectionView.collectionViewLayout = self.makeCollectionViewLayout()
        
        
        self.secondCollectionView.dataSource = self
        self.secondCollectionView.register(UINib(nibName: "CompositionalLayoutCell", bundle: nil), forCellWithReuseIdentifier: "CompositionalLayoutCell")
        
        self.secondCollectionView.collectionViewLayout = self.makeSecondCollectionViewLayout()
        
    }

    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        // 첫번째 아이템(세로로 긴 네모)
        let firstItem = self.makeItem(widthDimension: 1/3, heightDimension: 1)
        
        // 두번째 아이템(가로로 긴 네모)
        let secondItem = self.makeItem(widthDimension: 1, heightDimension: 1/2)
        
        // 세번째, 네번째 아이템
        let thirdAndForthItem = self.makeItem(widthDimension: 1/2, heightDimension: 1)
        // 세번째, 네번째 감싸주기
        let thridAndForthGroup = self.makeGroup(direction: .horizontal,
                                                widthDimension: 1, heightDimension: 1/2,
                                                subItem: thirdAndForthItem, count: 2)
        
        // 두번째, [세번째, 네번째] 감싸주기
        let secondToForthItemGroup = self.makeGroup(direction: .vertical,
                                                    widthDimension: 2/3, heightDimension: 1,
                                                    subItems: [secondItem, thridAndForthGroup])
        
        
        // 첫번째, [두번째, [세번째, 네번째]] 감싸주기
        let topGroup = self.makeGroup(direction: .horizontal,
                                      widthDimension: 1, heightDimension: 2/3,
                                      subItems: [firstItem, secondToForthItemGroup])
        
        // 다섯번째, 여섯번째, 일곱번째 아이템
        let bottomSmallItem = self.makeItem(widthDimension: 1/3, heightDimension: 1)
        
        // 다섯번째, 여섯번째, 일곱번째 감싸주기
        let bottomGroup = self.makeGroup(direction: .horizontal,
                                         widthDimension: 1, heightDimension: 1/3,
                                         subItem: bottomSmallItem, count: 3)
        
        // 마지막 [첫번째, [두번째, [세번째, 네번째]]] 랑 [다섯번째, 여섯번째, 일곱번째] 감싸주기
        let finalContainerGroup = self.makeGroup(direction: .vertical,
                                                 widthDimension: 1, heightDimension: 1,
                                                 subItems: [topGroup, bottomGroup])
        
        let section = NSCollectionLayoutSection(group: finalContainerGroup)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func makeSecondCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        // 화면 사이즈에 따라 그룹에 들어가는 아이템 갯수 변경
        let itemsPerRow = self.traitCollection.horizontalSizeClass == .compact ? 3 : 6
        let fraction: CGFloat = 1 / CGFloat(itemsPerRow)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(1),
                                                                        heightDimension: .absolute(100)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// collectionview delegate, datasource
extension SecondCompositionalLayout: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompositionalLayoutCell", for: indexPath) as! CompositionalLayoutCell
        
        cell.configureCell(cellVM: self.colorArray[indexPath.row])
        
        return cell
    }
    
    
}
