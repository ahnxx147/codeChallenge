//
//  CvsSearchViewModel.swift
//  cvs-code-challenge
//
//  Created by Jacob Ahn on 7/26/24.
//

import Foundation

class CvsSearchViewModel {
    public var flickrImageList: [FlickerImageResponse] = []
    
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol = Service.shared) {
        self.service = service
    }
    
    var numberOfImages: Int {
        return flickrImageList.count
    }
    
    func image(index: Int) -> FlickerImageResponse? {
        guard index >= 0 && index < flickrImageList.count else {
            return nil
        }
        return flickrImageList[index]
    }
    
    func getImages(withSearchText: String, completion: @escaping () -> Void) {
        Service.shared.getImage(searchTxt: withSearchText) { [weak self] images in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.flickrImageList = images ?? []
                completion()
            }
        }
    }
    
    func parseDescriptionText(text: String) -> (height: String?, width: String?) {
        let regexPattern = "<img[^>]+width=\"(\\d+)\"[^>]+height=\"(\\d+)\""
        if let regex = try? NSRegularExpression(pattern: regexPattern, options: []) {
            let nsRange = NSRange(text.startIndex..., in: text)
            let matches = regex.matches(in: text, range: nsRange)
            
            for match in matches {
                if let widthRange = Range(match.range(at: 1), in: text),
                   let heightRange = Range(match.range(at: 2), in: text) {
                    let heightText = String(text[widthRange])
                    let widthText = String(text[heightRange])
                    return (heightText, widthText)
                }
            }
        }
        return (nil, nil)
    }
    
}
