//
//  ViewController.swift
//  Multiple-Sections
//
//  Created by Maitree Bain on 8/18/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //1
    
    enum Section: Int,CaseIterable {
        case grid
        case single
        //Add a third section
        var columnCount: Int {
            switch self {
            case .grid:
                return 4 //columns
            case .single:
                return 1 //column
            }
        }
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Int>
    
    private var datasource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        configureCollectionView()
        configureDatasource()
    }
    
    private func configureCollectionView() {
        
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .systemGroupedBackground
        //register supplementary view
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnviornment) -> NSCollectionLayoutSection? in
            
            //find out what section we are working with
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            
            let columns = sectionType.columnCount //1 or 4
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            //add content insets
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            
            let groupHeight = columns == 1 ? NSCollectionLayoutDimension.absolute(200) : NSCollectionLayoutDimension.fractionalWidth(0.25)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            
            //configure headerview
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
        return layout
    }
    
    private func configureDatasource() {
        datasource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as? LabelCell else {
                fatalError("could not dequeue labelCell")
            }
            
            cell.textLabel.text = "\(item)"
            
            if indexPath.section == 0 {
                cell.backgroundColor = .blue
            } else {
                cell.backgroundColor = .brown
            }
            return cell
                
            })
        
        datasource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let headerView = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? HeaderView else {
                fatalError()
            }
            
            headerView.textLabel.text = "\(Section.allCases[indexPath.section])".capitalized
            return headerView
        }
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
            snapshot.appendSections([.grid, .single])
            snapshot.appendItems(Array(1...12), toSection: .grid)
            snapshot.appendItems(Array(13...20), toSection: .single)
            datasource.apply(snapshot, animatingDifferences: true)
        }
        
}

