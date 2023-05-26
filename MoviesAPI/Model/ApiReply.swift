//
//  ApiReply.swift
//  MoviesAPI
//
//  Created by user232105 on 4/18/23.
//

import Foundation

struct ApiReply: Decodable {
    
    var searchType: String
    var expression: String
    var errorMessage: String
    
    var results: [SearchResponse]
    
}
