//
//  RandomHeightCellLayoutViewController.swift
//  ios14New
//
//  Created by master on 2020/11/16.
//

/*
 컬렉션뷰에 여러줄로 나눠 셀 높이가 서로다른 셀을 추가할 때 그냥 데이터를 넣어주면 아래와 같이 나열된다.
 - ex 2줄의 경우
 [section]
 -------- --------
            
 --------
 
          --------
 --------
    
 
 --------
 
 [section]
 -------- --------
            
 -------- --------
 
 --------
    
 
 --------
 
 위에처럼 배치되는 애들을 아래처럼 넣고싶을 때의 레이아웃이다.
 
 [section]
 -------- --------
            
 --------
 --------
          --------
     
 
 --------
 
 [section]
 -------- --------
    
 -------- --------
 --------
    
 
 --------
 
 */

import UIKit

class RandomHeightCellLayoutViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let colorDicArray = ColorArray.makeColorDicSectionData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CompositionalLayoutCell", bundle: nil), forCellWithReuseIdentifier: "CompositionalLayoutCell")
        self.collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        self.collectionView.collectionViewLayout = self.createCompositionalLayout(divideCount: 2)
    }

    
    /// Compositional Layout 그룹 여러개
    /// - Parameter divideRow: 그룹을 몇개로 나눌건가요?
    /// - Returns: UICollectionViewCompositionalLayout
    private func createCompositionalLayout(divideCount: Int) -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .estimated(50)))
            
            
            var itemList = [[NSCollectionLayoutItem]]()
            itemList.append(contentsOf: Array(repeating: [NSCollectionLayoutItem](), count: divideCount))
            
            let key:String = Array(self.colorDicArray.keys)[sectionIndex]
            for dataIndex in 0..<self.colorDicArray[key]!.count {
                let remainValue = dataIndex % divideCount
                itemList[remainValue].append(item)
            }
            
            var groupList = [NSCollectionLayoutGroup]()
            let widthDimension: CGFloat = 1.0 / CGFloat(divideCount)
            for item in itemList {
                if item.count > 0 {
                    
                    let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize:.init(widthDimension: .fractionalWidth(widthDimension),
                                                                                          heightDimension: .estimated(150)),
                                                                         subitems: item)
                    verticalGroup.interItemSpacing = .fixed(5)
                    groupList.append(verticalGroup)
                }
            }
            let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(1),
                                                                                  heightDimension: .estimated(150)),
                                                                   subitems: groupList)
            
            let section = NSCollectionLayoutSection(group: nestedGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            section.interGroupSpacing = 5
            section.boundarySupplementaryItems = [self.createHeader()]
            return section
        }
        
        return layout
    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(70))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return headerElement
    }
}

extension RandomHeightCellLayoutViewController: UICollectionViewDataSource {
    // section의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Array(colorDicArray.keys).count
    }
    
    // Section당 아이템 개수.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Key 별 item 갯수
        let key:String = Array(colorDicArray.keys)[section]
        return colorDicArray[key]!.count
    }
    
    // Make Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
            fatalError("Could not dequeue SectionHeader")
        }
        let key:String = Array(colorDicArray.keys)[indexPath.section]
        headerView.configureHeader(title: key)
        return headerView
    }
    
    // Make Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompositionalLayoutCell", for: indexPath) as! CompositionalLayoutCell
        
        let key:String = Array(colorDicArray.keys)[indexPath.section]
        if let vm:ColorVM = colorDicArray[key]?[indexPath.row] {
            // 데이터 꾸며주는 부분
            cell.configureRandomHeightCell(cellVM: vm)
        }
        
        return cell
    }
    
    // Random Height
}
