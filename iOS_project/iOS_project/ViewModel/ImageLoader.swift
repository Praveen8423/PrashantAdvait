//
//  ImageLoader.swift
//  iOS_project
//
//  Created by Apple on 12/05/24.
//
import SwiftUI
import Foundation

class ImageLoader: ObservableObject {
    @Published var images: [ImageObjectModel] = []
    private var currentPage = 1
    private var isLoading = false
    private let limit = 100
    private let baseURL = "https://acharyaprashant.org/api/v2/content/misc/media-coverages"
    // Function to fetch images from the API
    func fetchImages() {
        guard !isLoading else { return }
        isLoading = true
        
        let urlString = "\(baseURL)?limit=\(limit)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.isLoading = false }
            guard let data = data, error == nil else {
                print("Error fetching images: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let response = try JSONDecoder().decode([ImageObjectModel].self, from: data)
                DispatchQueue.main.async {
                    self.images.append(contentsOf: response)
                    self.currentPage += 1
                }
            } catch {
                print("Error decoding images: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}


struct ImageObject: Identifiable, Decodable {
    let id: String
    let title: String
    let language: String
    let thumbnail: Thumbnail
    let coverageURL: String
    let publishedAt: String
    let publishedBy: String
    let backupDetails: BackupDetails
    
    var imageURL: URL {
        return URL(string: "\(thumbnail.domain)/\(thumbnail.basePath)/0/\(thumbnail.key)")!
    }
}

//struct MediaCoverage: Decodable {
//    let id: String
//    let title: String
//    let language: String
//    let thumbnail: Thumbnail
//    let mediaType: Int
//    let coverageURL: String
//    let publishedAt: String
//    let publishedBy: String
//    let backupDetails: BackupDetails
//    
//    func toImageObjectModel() -> ImageObjectModel {
//        return ImageObjectModel(id: id, title: title, language: language, thumbnail: thumbnail, mediaType: mediaType, coverageURL: coverageURL, publishedAt: publishedAt, publishedBy: publishedBy, backupDetails: backupDetails)
//    }
//}

//extension ImageObjectModel {
//    func toImageObjectModel() -> ImageObjectModel {
//        return ImageObjectModel(id: id, title: title, language: language, thumbnail: thumbnail, coverageURL: coverageURL, publishedAt: publishedAt, publishedBy: publishedBy, backupDetails: backupDetails)
//    }
//}
//struct ImageObjectModelResponse: Decodable {
//    let data: [ImageObjectModel]
//}
