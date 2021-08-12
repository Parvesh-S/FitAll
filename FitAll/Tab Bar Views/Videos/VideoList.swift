//
//  VideoList.swift
//  FitAll
//
//  Created by keerthana on 11/30/20.
//

import SwiftUI

struct VideoList: View {
    let input: String
    @State private var list = [Video]()
    var body: some View {
        List {
            ForEach(list){ video in
                NavigationLink(destination:
                                WebView(url: "http://www.youtube.com/embed/\(video.youtubeID)")
                        .navigationBarTitle(Text("Play Workout Video"), displayMode: .inline)
                ){
                    VideoItem(video: video)
                }
                

            }//end of List
            
        }
        .onAppear() {
            self.searchForVideos(input: input)
            self.list = videosFoundList
        }
       
    }
    
  
    func searchForVideos(input: String)
    {
        obtainYoutubeData(query: input.trimmingCharacters(in: .whitespacesAndNewlines))
        
    }
    
}



