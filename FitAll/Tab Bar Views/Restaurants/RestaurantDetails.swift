//
//  RestaurantDetails.swift
//  FitAll
//
//  Created by keerthana on 12/1/20.
//

import SwiftUI
import MapKit

struct RestaurantDetails: View {
    let rest: Restaurant
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                Text(rest.name)
            }
            
            Section(header: Text("Address")) {
                VStack(alignment:.leading) {
                    Text(rest.address)
                }
                
            }
            
//            Section(header: Text("Distance")) {
//                Text("\(tripDistance) miles away")
//            }
//
            Section(header: Text("Phone Number")) {
                HStack{
                    Image(systemName: "phone")
                        .imageScale(.medium)
                        .font(Font.title.weight(.regular))
                    Text(rest.phone)
                }
            }
            
            Section(header: Text("Website")) {
                NavigationLink(destination: WebView(url: rest.website), label: {
                    HStack {
                        
                        Image(systemName: "globe")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                        Text("Go To Website")
                    }
                    .foregroundColor(.pink)
                })
                
            }
            Section(header: Text("Show Restaurant Location on Map")) {

                NavigationLink(destination: locationOnMap) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                        Text("Show Restaurant Location on Map")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.pink)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .leading)

                }

            }
            .navigationBarTitle(Text("\(rest.name) Details"), displayMode: .inline)

            
            
        }
            
    }
    
    var locationOnMap: some View {
       
        return AnyView(MapView(mapType: MKMapType.standard, latitude: rest.latitude,
                                   longitude: rest.longitude, delta: 15.0, deltaUnit: "degrees",
                                   annotationTitle: rest.name, annotationSubtitle: "\(rest.locality)")
                        .navigationBarTitle("\(rest.name) Location", displayMode: .inline)
                .edgesIgnoringSafeArea(.all) )
        

       }
}

