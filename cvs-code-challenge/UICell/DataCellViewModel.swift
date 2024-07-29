//
//  DetailViewModel.swift
//  cvs-code-challenge
//
//  Created by Jacob Ahn on 7/28/24.
//

import Foundation
import UIKit

class DataCellViewModel {
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol = Service.shared) {
        self.service = service
    }
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        service.downloadImage(url: url, completion: completion)
    }
    
}
