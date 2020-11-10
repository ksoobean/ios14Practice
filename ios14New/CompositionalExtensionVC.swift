//
//  CompositionalExtensionVC.swift
//  ios14New
//
//  Created by master on 2020/11/10.
//

import UIKit

enum Direction {
    case horizontal
    case vertical
}

class CompositionalExtensionVC: UIViewController {

    /// 가로/세로 등분할 비율로 아이템 만들기
    func makeItem(widthDimension: CGFloat, heightDimension: CGFloat) -> NSCollectionLayoutItem {
        return NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthDimension), heightDimension: .fractionalHeight(heightDimension)))
    }
    
    /// 다르게생긴 아이템들로 그룹 만들기
    func makeGroup(direction: Direction, widthDimension: CGFloat, heightDimension: CGFloat, subItems: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
        
        switch direction {
        
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthDimension), heightDimension: .fractionalHeight(heightDimension)), subitems: subItems)
        case .vertical:
            return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthDimension), heightDimension: .fractionalHeight(heightDimension)), subitems: subItems)
        }
    }
    
    /// 똑같이 아이템으로 그룹 만들기
    func makeGroup(direction: Direction, widthDimension: CGFloat, heightDimension: CGFloat, subItem: NSCollectionLayoutItem, count: Int) -> NSCollectionLayoutGroup {
        
        switch direction {
        
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthDimension), heightDimension: .fractionalHeight(heightDimension)), subitem: subItem, count: count)
        case .vertical:
            return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthDimension), heightDimension: .fractionalHeight(heightDimension)), subitem: subItem, count: count)
        }
    }
}
