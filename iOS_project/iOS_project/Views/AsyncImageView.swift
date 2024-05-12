//
//  AsyncImageView.swift
//  iOS_project
//
//  Created by Apple on 12/05/24.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    private let imageObjectModel: ImageObjectModel
    
    init(imageObjectModel: ImageObjectModel) {
        self.imageObjectModel = imageObjectModel
    }
    
    var body: some View {
        Group {
            if let imageURL = URL(string: "\(imageObjectModel.thumbnail?.domain ?? "")/\(imageObjectModel.thumbnail?.basePath ?? "")/0/\(imageObjectModel.thumbnail?.key ?? "")") {
                RemoteImage(url: imageURL)
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear {
            imageLoader.fetchImages()
        }
    }
}




//#Preview {
//    AsyncImageView()
//}
struct RemoteImage: View {
    private let url: URL
    @State private var imageData: Data?
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            // Placeholder or loading indicator
            ProgressView()
                .onAppear(perform: loadImage)
        }
    }
    
    private func loadImage() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                imageData = data
            }
        }.resume()
    }
}
