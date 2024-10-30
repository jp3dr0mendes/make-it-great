//
//  SearchViewController.swift
//  Make-it-Great
//
//  Created by Yane dos Santos on 29/10/24.
//

import Foundation
import UIKit
import SwiftUI

class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        if searchText.isEmpty {
                filteredData = data
            } else {
                filteredData = data.enumerated().compactMap { index, name in
                    return name.localizedCaseInsensitiveContains(searchText) ? data[index].nome : nil
                }
            }

    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @Binding var data: [Food]
    @Binding var selected: String
    
    init(data: Binding <[Food]>, selected: Binding<String>) {
        self._data = data
        self._selected = selected
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configurando o UISearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Procure por emoji"
        searchController.searchBar.delegate = self
        
        navigationItem.hidesSearchBarWhenScrolling = false

        navigationItem.searchController = searchController
                
        
        definesPresentationContext = true
    }
    
}
