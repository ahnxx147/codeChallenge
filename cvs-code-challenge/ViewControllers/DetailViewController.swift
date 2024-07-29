//
//  DetailViewController.swift
//  cvs-code-challenge
//
//  Created by Jacob Ahn on 7/27/24.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    private let detailImageView = UIImageView()
    private let titleLabel = UILabel()
    private let widthLabel = UILabel()
    private let heightLabel = UILabel()
    private let randomInfoLabel = UILabel()
    
    private let detailImageURL: URL
    private let titleString: String
    private let widthString: String
    private let heightString: String
    private let randomInfoString: String
        
    private let viewModel = DetailViewModel()
    
    public init(detailImageURL: URL, titleString: String, widthString: String, heightString: String, randomInfoString: String) {
        self.detailImageURL = detailImageURL
        self.titleString = titleString
        self.widthString = widthString
        self.heightString = heightString
        self.randomInfoString = randomInfoString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loadImage()
    }
    
    
    private func setupUI(){
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.contentMode = .scaleAspectFit
        detailImageView.isAccessibilityElement = true
        detailImageView.accessibilityLabel = "Image \(titleString)"
        view.addSubview(detailImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.isAccessibilityElement = true
        titleLabel.accessibilityLabel = "Title"
        titleLabel.accessibilityValue = titleString
        view.addSubview(titleLabel)
        
        widthLabel.translatesAutoresizingMaskIntoConstraints = false
        widthLabel.isAccessibilityElement = true
        widthLabel.numberOfLines = 0
        widthLabel.lineBreakMode = .byWordWrapping
        widthLabel.accessibilityLabel = "Width"
        view.addSubview(widthLabel)
        
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.isAccessibilityElement = true
        heightLabel.accessibilityLabel = "height"
        heightLabel.numberOfLines = 0
        heightLabel.lineBreakMode = .byWordWrapping
        view.addSubview(heightLabel)
        
        randomInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        randomInfoLabel.isAccessibilityElement = true
        randomInfoLabel.numberOfLines = 0
        randomInfoLabel.lineBreakMode = .byWordWrapping
        randomInfoLabel.accessibilityLabel = "\(randomInfoString)"
        view.addSubview(randomInfoLabel)
        
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            detailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            
            widthLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            widthLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            widthLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            
            heightLabel.topAnchor.constraint(equalTo: widthLabel.bottomAnchor, constant: 20),
            heightLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            heightLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            
            randomInfoLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 20),
            randomInfoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            randomInfoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            randomInfoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    private func loadImage() {
        viewModel.downloadImage(url: detailImageURL) { [weak self] image in
            if let image = image {
                self?.detailImageView.image = image
            } else {
                //handle error here
            }
        }
   
        
        titleLabel.text = "title: \(titleString)"
        widthLabel.text = "width: \(widthString)"
        heightLabel.text = "heigth: \(heightString)"
        randomInfoLabel.text = "random: \(randomInfoString)"
    }
}
