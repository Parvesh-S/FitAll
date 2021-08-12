//
//  YoutubeVideoData.swift
//  FitAll
//
//  Created by keerthana on 11/27/20.
//

import Foundation
import SwiftUI
 
// Declare countryFound as a global mutable variable accessible in all Swift files
var videosFoundList = [Video]();
var youtubeApiKey = "AIzaSyD1dLvIy5g1VgTHe0D3Hblbrfr5mPh1DtY"
 
fileprivate var previousCategory = "", previousQuery = ""
 

/*
===================================
MARK: - Obtain Cocktail Data from API By Name
====================================
*/
public func obtainYoutubeData(query: String) {
   
    // Avoid executing this function if already done for the same category and query
    if query == previousQuery {
        return
    } else {
        previousQuery = query
    }
   
    // Initialization
    videosFoundList = [Video]();


    // Replace space with UTF-8 encoding of space with %20
    let searchQuery = query.replacingOccurrences(of: " ", with: "%20")

    let apiUrl = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=50&q=\(searchQuery)%20workout&key=\(youtubeApiKey)"
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: apiUrl)
    
        /*----------------------------------------------
         JSON data is obtained from the API. Process it.
        ------------------------------------------------*/
        
        do {
            /*
             Foundation framework’s JSONSerialization class is used to convert JSON data
             into Swift data types such as Dictionary, Array, String, Number, or Bool.
             */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                               options: JSONSerialization.ReadingOptions.mutableContainers)
            /*
             JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
             Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
             where Dictionary Key type is String and Value type is Any (instance of any type)
             */
            
            if let jsonObject = jsonResponse as? [String:Any] {
                
                if let jsonArray = jsonObject["items"] as? [Any] {
                
                    for videoItem in jsonArray {
                        
                        var videoFound: Video
                        var videoDictionary = Dictionary<String, Any>()
                        if let object = videoItem as? [String: Any] {
                            videoDictionary = object
                        }
                
                       
                        //----------------
                        // Initializations
                        //----------------

                        var vidName = "", theID = "", date = ""

                        //--------------------
                        // Obtain Video Name and DATE
                        //--------------------
                        if let snippetArray = videoDictionary["snippet"] as? [String:Any] {
                            
                            if let titVid = snippetArray["title"] as? String
                            {
                                vidName = titVid
                            }
                            
                            if let dateOfVid = snippetArray["publishedAt"] as? String
                            {
                                date = dateOfVid
                            }
                        }
                    
                        
                        //--------------------------
                        // Obtain Video ID
                        //--------------------------

                        if let idArray = videoDictionary["id"] as? [String:Any] {
                            
                            if let idOfVideo = idArray["videoId"] as? String
                            {
                                theID = idOfVideo
                            }
                            
                           
                        }
                    

                        //----------------------------------------------------------
                        // Construct a New Cocktail Struct and Set it to cocktailFound
                        //----------------------------------------------------------

                        videoFound = Video(id: UUID(), name: vidName, youtubeID: theID, date: date)
                        
                        //Append cocktail to cocktailsFoundList
                        videosFoundList.append(videoFound)
                        
                    }

                    }
            }
            
            
       
        } catch {
            return
        }
    
}
