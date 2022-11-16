//
//  ImageFromWeb.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation
import UIKit

final class ImageFromWeb {
    static private(set) var shared = ImageFromWeb()
    
    func loadImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        loadData(url: url) { data, error in
            guard let data, let image = UIImage(data: data) else {
                completion(nil, error)
                return
            }
            
            completion(image, error)
        }
    }
    
    func loadData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let cachedFile = FileManager.default
            .temporaryDirectory
            .appendingPathComponent(url.lastPathComponent, isDirectory: false)
        
        if let data = try? Data(contentsOf: cachedFile) {
            completion(data, nil)
            return
        }
        
        download(url: url, toFile: cachedFile) { error in
            let data = try? Data(contentsOf: cachedFile)
            completion(data, error)
        }
    }
}

private extension ImageFromWeb {
    func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { tempURL, response, error in
            guard let tempURL = tempURL else {
                completion(error)
                return
            }

            do {
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }

                try FileManager.default.copyItem(at: tempURL, to: file)

                completion(nil)
            } catch _ {
                completion(error)
            }
        }

        task.resume()
    }
}
