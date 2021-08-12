//
//  VideoItem.swift
//  FitAll
//
//  Created by keerthana on 11/30/20.
//

import SwiftUI

struct VideoItem: View {
    let video: Video
    
    var body: some View {
        getImageFromUrl(url: "https://img.youtube.com/vi/\(video.youtubeID)/mqdefault.jpg", defaultFilename: "ImageUnavailable")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80.0)
            
            
        
        VStack(alignment:.leading) {
            Text(video.name)
            Text(String(video.date.dropLast(10)))
        }
    }
    

}

//struct VideoItem_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoItem()
//    }
//}
