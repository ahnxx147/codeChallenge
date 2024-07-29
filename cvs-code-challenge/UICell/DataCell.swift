//
//  DataCell.swift
//  cvs-code-challenge
//
//  Created by Jacob Ahn on 7/27/24.
//

import Foundation
import UIKit

class DataCell: UITableViewCell {
    static let reuseIdentifier = "dataCell"
    let imageViewCell = UIImageView()
    let vm = DataCellViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.contentMode = .scaleAspectFit
        imageViewCell.isAccessibilityElement = true
        imageViewCell.accessibilityLabel = "Flickr Image"
        imageViewCell.clipsToBounds = true
        contentView.addSubview(imageViewCell)
        
        NSLayoutConstraint.activate([
            imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func loadAndDisplayImage(from url: URL?) {
        guard let url = url else {
            imageViewCell.image = nil
            return
        }
        vm.downloadImage(url: url) { [weak self] image in
            if let image = image {
                self?.imageViewCell.image = image
            } else {
                //handle error here
            }
        }
    }
}
