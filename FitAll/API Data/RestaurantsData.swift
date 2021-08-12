//
//  RestaurantsData.swift
//  FitAll
//
//  Created by keerthana on 11/27/20.
//


import Foundation
import SwiftUI
import CoreLocation

var restaurantsFoundList = [Restaurant]();

fileprivate let zApiKey = "36d5dabba4eb95ec68b69ed410f541e0"

//======================================================
// Get Nutrition Data from the API for the Food Item with UPC.
// Universal Product Code (UPC) is a barcode symbology consisting of
// 12 numeric digits that are uniquely assigned to a trade item.
// =================================================================
// */
public func obtainRestaurantDataByLocation() {
    restaurantsFoundList = [Restaurant]();

    let myLocation = currentLocation()
    /*
    *********************************************
    *   Obtaining API Search Query URL Struct   *
    *********************************************
    */

    var apiQueryUrlStruct: URL?
//    let curLat =  Double(round(100000*currentLocation().latitude)/100000)
//    let curLong = Double(round(100000*currentLocation().longitude)/100000)
    let stringUrl = "https://developers.zomato.com/api/v2.1/search?count=50&lat=\(myLocation.latitude)&lon=\(myLocation.longitude)&radius=50000"
    if let urlStruct = URL(string: stringUrl) {
         apiQueryUrlStruct = urlStruct
     } else {
         // foodItem will have the initial values set as above
         return
     }
   

    /*
    *******************************
    *   HTTP GET Request Set Up   *
    *******************************
    */

    let headers = [
        "user-key": zApiKey
    ]

    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)

    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    /*
    *********************************************************************
    *  Setting Up a URL Session to Fetch the JSON File from the API     *
    *  in an Asynchronous Manner and Processing the Received JSON File  *
    *********************************************************************
    */

    /*
     Create a semaphore to control getting and processing API data.
     signal() -> Int    Signals (increments) a semaphore.
     wait()             Waits for, or decrements, a semaphore.
     */
    let semaphore = DispatchSemaphore(value: 0)

    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
        URLSession is established and the JSON file from the API is set to be fetched
        in an asynchronous manner. After the file is fetched, data, response, error
        are returned as the input parameter values of this Completion Handler Closure.
        */

        // Process input parameter 'error'
        guard error == nil else {
            semaphore.signal()
            return
        }

        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            semaphore.signal()
            return
        }

        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            semaphore.signal()
            return
        }

        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
            Foundation framework’s JSONSerialization class is used to convert JSON data
            into Swift data types such as Dictionary, Array, String, Number, or Bool.
            */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                              options: JSONSerialization.ReadingOptions.mutableContainers)

            if let jsonObject = jsonResponse as? [String:Any] {

                if let jsonArray = jsonObject["restaurants"] as? [Any] {

                    for rest in jsonArray {

                        var restFound: Restaurant
                        var restaurantInfoDictionary = Dictionary<String, Any>()
                        if let item = rest as? [String:Any] {
                        
                            if let object = item["restaurant"] as? [String: Any] {
                                restaurantInfoDictionary = object
                            }
                        }
                        
                        
                        
                        //----------------
                        // Initializations
                        //----------------

                        var rName = "", rAddy = "", rImage = "", rPhone = "", rWeb = "",
                            rLat = 0.0, rLong = 0.0, rLocality = ""

                        //--------------------
                        // Obtain Restaurant Name
                        //--------------------

                        if let nameOfRestaurant = restaurantInfoDictionary["name"] as? String {
                             rName = nameOfRestaurant
                        }
                        
                        //--------------------
                        // Obtain Restaurant Name
                        //--------------------
                        if let locationAddy = restaurantInfoDictionary["location"] as? [String: Any] {
                            
                            if let addy = locationAddy["address"] as? String {
                                rAddy = addy
                            }
                            
                            if let lat = locationAddy["latitude"] as? String {
                                rLat = (lat as NSString).doubleValue                            }
                            
                            if let long = locationAddy["longitude"] as? String {
                                rLong = (long as NSString).doubleValue
                            }
                            
                            if let loc = locationAddy["locality_verbose"] as? String {
                                rLocality = loc
                            }
                        }
                        
                        //--------------------
                        // Obtain Restaurant Phone Number
                        //--------------------
                        if let phone = restaurantInfoDictionary["phone_numbers"] as? String {
                            
                            rPhone = phone;
                        }
                        
                        //--------------------
                        // Obtain Restaurant Website
                        //--------------------
                        if let url = restaurantInfoDictionary["url"] as? String {
                            
                            rWeb = url;
                        }
                        
                        
                        //--------------------
                        // Obtain Restaurant Website
                        //--------------------
                        if let img = restaurantInfoDictionary["thumb"] as? String {
                            
                            rImage = img;
                        }
                        
                    
                        restFound = Restaurant(id: UUID(), name: rName, phone: rPhone, address: rAddy, website: rWeb, latitude: rLat, longitude: rLong, locality: rLocality, imageid: rImage)

                         

                          //Append cocktail to cocktailsFoundList
                          restaurantsFoundList.append(restFound)
              }
                    




                    }
                else {
                    // countryFound will have the initial values set as above
                    semaphore.signal()
                    return
                }

                }
            } catch {
                // countryFound will have the initial values set as above
                semaphore.signal()
                return
            }
                
               
                

            semaphore.signal()
            }).resume()

            _ = semaphore.wait(timeout: .now() + 10)



}


