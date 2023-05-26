//
//  InTheater.swift
//  MoviesAPI
//
//  Created by user232105 on 4/18/23.
//

import Foundation

struct InTheaterResponse: Decodable {
    
    var id: String
    var title: String
    var image: String
    var releaseState: String
    var runtimeMins: String
    var genres: String
    var imDbRating: String
    
}


struct InTheaterReply: Decodable {
    
    var errorMessage: String
    var items: [InTheaterResponse]
}
