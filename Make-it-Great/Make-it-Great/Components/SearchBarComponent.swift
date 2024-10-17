//
//  SearchBarComponent.swift
//  Make-it-Great
//
//  Created by Yane dos Santos on 17/10/24.
//

import Foundation
import UIKit
import SwiftUI

class SearchBarComponent: UICollectionViewController, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        filteredData = searchText.isEmpty ? data : data.filter { $0.localizedCaseInsensitiveContains(searchText) }
        collectionView.reloadData()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @Binding var text: String
    @Binding var data: [String]
    var filteredData: [String] = []
    
    init(data: Binding<[String]>, text: Binding<String>) {
        self._data = data
        self._text = text
        super.init(collectionViewLayout: .init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = text
        searchController.searchBar.delegate = self
        
        navigationItem.hidesSearchBarWhenScrolling = false

        navigationItem.searchController = searchController
                
        
        definesPresentationContext = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isActive ? filteredData.count : data.count
//        return 12
    }
    
}

#Preview {
    UINavigationController(rootViewController: SearchBarComponent(data: .constant([""]), text: .constant("")))
}
