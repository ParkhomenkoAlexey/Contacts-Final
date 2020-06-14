//
//  ContactsViewController.swift
//  Contacts
//
//  Created by Алексей Пархоменко on 13.06.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    
    
    let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonItemTapped))
    let groupsBarButtonItem = UIBarButtonItem(title: "Groups", style: .plain, target: self, action: #selector(groupsBarButtonItemTapped))
    
    var dataSource: UICollectionViewDiffableDataSource<ContactsModel.UserCollection, ContactsModel.User>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<ContactsModel.UserCollection, ContactsModel.User>! = nil
    var collectionView: UICollectionView!
    
    let contactsModel = ContactsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    private func setupNavigationBar() {
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.leftBarButtonItem = groupsBarButtonItem
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Contacts"
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseId)
        collectionView.register(FavouriteCell.self, forCellWithReuseIdentifier: FavouriteCell.reuseId)
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: ContactCell.reuseId)
        
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvirment) -> NSCollectionLayoutSection? in
            
            let type = self.currentSnapshot.sectionIdentifiers[sectionIndex].type
            
            switch type {
            case .profile:
                return self.createProfile()
            case .favoutires:
                return self.createFavourites()
            case .contacts:
                return self.createContacts()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        layout.configuration = config
        return layout
    }
    
    private func createProfile() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(58))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    private func createFavourites() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createContacts() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(55))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 1
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    private func reloadData() {
        currentSnapshot = NSDiffableDataSourceSnapshot<ContactsModel.UserCollection, ContactsModel.User>()
        
        contactsModel.collections.forEach { (collection) in
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.users)
        }
        
        
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
    // MARK: - DataSource
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ContactsModel.UserCollection, ContactsModel.User>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, user) -> UICollectionViewCell? in
            
            
            let type = self.currentSnapshot.sectionIdentifiers[indexPath.section].type
            
            switch type {
            case .profile:
                return self.configure(collectionView: collectionView, cellType: ProfileCell.self, with: user, for: indexPath)
            case .favoutires:
                return self.configure(collectionView: collectionView, cellType: FavouriteCell.self, with: user, for: indexPath)
            case .contacts:
                return self.configure(collectionView: collectionView, cellType: ContactCell.self, with: user, for: indexPath)
            }
        })
    }
}


// MARK: - Actions
extension ContactsViewController {
    @objc func addBarButtonItemTapped() {
        print(#function)
    }
    
    @objc func groupsBarButtonItemTapped() {
        print(#function)
    }
}

// MARK: - UISearchBarDelegate
extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

