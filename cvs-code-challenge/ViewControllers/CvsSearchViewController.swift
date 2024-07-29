//
//  CvsSearchViewController.swift
//  cvs-code-challenge
//
//  Created by Jacob Ahn on 7/26/24.
//
import UIKit
import Foundation
class CvsSearchViewController: UIViewController,UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private let cvsSearchViewModel = CvsSearchViewModel()
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search Flickr Images"
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DataCell.self, forCellReuseIdentifier: DataCell.reuseIdentifier)
        view.addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func searchImages(text: String) {
        cvsSearchViewModel.getImages(withSearchText: text) {
            self.tableView.reloadData()
        }
    }
    
    //delegate calls
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cvsSearchViewModel.numberOfImages
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.reuseIdentifier, for: indexPath) as! DataCell
        let image = cvsSearchViewModel.flickrImageList[indexPath.row]
        cell.loadAndDisplayImage(from: image.imageUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = cvsSearchViewModel.flickrImageList[indexPath.row]
        
        let (heigth, width) = cvsSearchViewModel.parseDescriptionText(text: image.description)
        
        guard let imageURL = image.imageUrl else {
            return
        }
        
        let detailVC = DetailViewController(detailImageURL: imageURL, titleString: image.title, widthString: width ?? "", heightString: heigth ?? "", randomInfoString: image.link)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchImages(text: searchText)
    }
}
