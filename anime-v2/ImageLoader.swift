//
//  ImageLoader.swift
//  anime-v2
//
//  Created by Jason Morales on 8/6/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoader: View {
    
    var url: String
    var contentMode: ContentMode
    
    
    var body: some View {
        SDWebImageLoader(url: url, contentMode: contentMode)
    }
}

struct SDWebImageLoader: View {
    
    var url: String
    var contentMode: ContentMode
    
    var body: some View {
        WebImage(url: URL(string: url)) {
            image in
            image.resizable()
        } placeholder: {
            ZStack{
                Rectangle().foregroundStyle(Color.gray).opacity(0.3)
                ProgressView()
            }
        }
         .aspectRatio(contentMode: contentMode)
            
    }
}

#Preview {
    ImageLoader(url: "https://picsum.photos/id/237/200/300", contentMode: .fit)
}
