//
//  Endpoint.swift
//  AuthApp
//
//  Created by Ali Hewiagh on 03/11/2020.
//

import Foundation




struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    let baseApiUrl = ""
}

// The base url od the API
extension Endpoint {
    
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseApiUrl
        components.path =  "/3/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}



/*
 Endpoints List: new endpoint can be added
 as a new func and called anywhere as
 Endpoint.newEndpoint(params if any)
*/
extension Endpoint {
    
    /*
     Get Single Movie Endpoint:
     Pass movie ID as a param to
     be set as a parameter.
    */
//    static func movie(id: String) -> Self {
//        Endpoint(
//            path: "movie/\(id)",
//            queryItems: [
//            URLQueryItem(name: "api_key", value: apiKey)
//        ])
//    }
    
    /*
     Get The List of the Movies Endpoint:
     PageNumber params is required to
     Load the movies in groups.
    */
//    static func movieList(pageNumber: String) -> Self {
//        Endpoint(
//            path: "discover/movie",
//            queryItems: [
//            URLQueryItem(name: "api_key", value: apiKey),
//            URLQueryItem(
//                name: "sort_by",
//                value: "release_date.asc"
//            ),
//            URLQueryItem(
//                name: "page",
//                value: pageNumber
//            )
//            ]
//        )
//    }
}
