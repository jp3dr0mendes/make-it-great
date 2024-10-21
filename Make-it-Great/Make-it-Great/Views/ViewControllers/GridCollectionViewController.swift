//
//  GridCollectionView.swift
//  Make-it-Great
//
//  Created by Yane dos Santos on 16/10/24.
//

import UIKit
import SwiftUI

private let reuseIdentifier = "Cell"

class GridCollectionControllerView: UICollectionViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
               filteredData = searchText.isEmpty ? data : data.filter { $0.localizedCaseInsensitiveContains(searchText) }
               collectionView.reloadData()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var data = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍋‍🟩", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🫛", "🥦", "🥬", "🥔", "🍠", "🫚"]
        var filteredData: [String] = []
    
    @Binding var selected: String
    @Binding var showingEmojiPicker: Bool
    
    init(selected: Binding<String>, showingEmojiPicker: Binding<Bool>) {
        self._selected = selected
        self._showingEmojiPicker = showingEmojiPicker
        super.init(collectionViewLayout: .init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 80)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        
        collectionView.collectionViewLayout = layout
        
        collectionView?.backgroundColor = .white
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Configurando o UISearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Procure por emoji"
        searchController.searchBar.delegate = self
        
        navigationItem.hidesSearchBarWhenScrolling = false

        navigationItem.searchController = searchController
                
        
        definesPresentationContext = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isActive ? filteredData.count : data.count
//        return 12
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .lightGray
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let image = UIImageView(frame: cell.contentView.bounds)
        
        let imageName = searchController.isActive ? filteredData[indexPath.row] : data[indexPath.row]
        image.image = UIImage(named: imageName)
        image.contentMode = .scaleAspectFit
        
        //cell.contentView.addSubview(image)
        
        let label = UILabel(frame: cell.contentView.bounds)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.text = searchController.isActive ? filteredData[indexPath.row] : data[indexPath.row]
        label.textColor = .black
        
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = "\(data[indexPath.row])"
        showingEmojiPicker = false
        print(selected)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Clicou em : \(indexPath.row)")
    }
}

#Preview {
    UINavigationController(rootViewController: GridCollectionControllerView(selected: .constant(""), showingEmojiPicker: .constant(true)))
}
