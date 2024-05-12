//
//  ContentView.swift
//  iOS_project
//
//  Created by Apple on 12/05/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var imageLoader = ImageLoader()
    @State private var selectedImage: ImageObjectModel?
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                        ForEach(imageLoader.images) { ImageObjectModel in
                            AsyncImageView(imageObjectModel: ImageObjectModel)
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    selectedImage = ImageObjectModel
                                }
                        }
                    }
                    .padding()
                }
            }
            .fullScreenCover(item: $selectedImage) { selectedImage in
                FullScreenImageView(imageObjectModel: selectedImage)
            }
            .onAppear {
                imageLoader.fetchImages()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
