//
//  SearchResponse.swift
//  MoviesAPI
//
//  Created by user232105 on 4/18/23.
//

import Foundation

struct SearchResponse: Decodable {
    
    var id: String
    var resultType: String
    var image: String
    var title: String
    var description: String
    
}
