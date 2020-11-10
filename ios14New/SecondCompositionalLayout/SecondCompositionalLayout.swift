//
//  SecondCompositionalLayout.swift
//  ios14New
//
//  Created by master on 2020/11/09.
//

import UIKit

class SecondCompositionalLayout: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let colorArray = ColorArray.makeColorData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CompositionalLayoutCell", bundle: nil), forCellWithReuseIdentifier: "CompositionalLayoutCell")
        
        self.collectionView.collectionViewLayout = self.makeCollectionViewLayout()
        
        self.view.addSubview(self.collectionView)
    }

    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        // 첫번째 아이템(세로로 긴 네모)
        let firstItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
        
        // 두번째 아이템(가로로 긴 네모)
        let secondItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
        
        // 세번째, 네번째 아이템
        let thirdAndForthItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        // 세번째, 네번째 감싸주기
        let thridAndForthGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitem: thirdAndForthItem, count: 2)
        
        // 두번째, [세번째, 네번째] 감싸주기
        let secondToForthItemGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1.0)), subitems: [secondItem, thridAndForthGroup])
        
        // 첫번째, [두번째, [세번째, 네번째]] 감싸주기
        let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2/3)), subitems: [firstItem, secondToForthItemGroup])
        
        // 다섯번째, 여섯번째, 일곱번째 아이템
        let bottomSmallItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)))
        
        // 다섯번째, 여섯번째, 일곱번째 감싸주기
        let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)), subitem: bottomSmallItem, count: 3)
        
        // 마지막 [첫번째, [두번째, [세번째, 네번째]]] 랑 [다섯번째, 여섯번째, 일곱번째] 감싸주기
        let finalContainerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [topGroup, bottomGroup])
        
        let section = NSCollectionLayoutSection(group: finalContainerGroup)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// collectionview delegate, datasource
extension SecondCompositionalLayout: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompositionalLayoutCell", for: indexPath) as! CompositionalLayoutCell
        
        cell.configureCell(cellVM: self.colorArray[indexPath.row])
        
        return cell
    }
    
    
}
