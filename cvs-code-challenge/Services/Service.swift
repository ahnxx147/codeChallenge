//
//  Service.swift
//  cvs-code-challenge
//
//  Created by Jacob Ahn on 7/28/24.
//

import Foundation
import UIKit

protocol ServiceProtocol {
    func getImage(searchTxt: String, completion: @escaping ([FlickerImageResponse]?) -> Void)
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void)
}

class Service: ServiceProtocol {
    static let shared = Service()
    
    private init() {}
    
    func getImage(searchTxt: String, completion: @escaping ([FlickerImageResponse]?) -> Void) {
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(searchTxt)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
             return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let serviceResponse = try JSONDecoder().decode(FlickrItem.self, from: data)
                let images = serviceResponse.items
                completion(images)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data , response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}
