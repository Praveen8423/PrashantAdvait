//
//  FullScreenImageView.swift
//  iOS_project
//
//  Created by Apple on 12/05/24.
//

import SwiftUI

struct FullScreenImageView: View {
    let imageObjectModel: ImageObjectModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            AsyncImageView(imageObjectModel: imageObjectModel)
                .aspectRatio(contentMode: .fit)
            
            VStack {
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                })
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

