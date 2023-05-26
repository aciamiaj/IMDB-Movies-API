//
//  TheaterDetailController.swift
//  MoviesAPI
//
//  Created by user232105 on 4/20/23.
//

import Foundation
import UIKit

class TheaterDetailController: UIViewController  {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var movietitle: UILabel!
    
    @IBOutlet weak var movieGenre: UILabel!
    
    var movie : InTheaterResponse?
    
    override func viewDidLoad() {
        if let movie = movie {
            movietitle?.text = movie.title
            movieGenre.text = movie.genres
            rating.text =  "\(movie.imDbRating) ⭐"
            if let url = URL(string: movie.image) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)
                            // Display the image in an UIImageView
                            self.imageView.image = image
                        }
                    }
                }.resume()
            }

        }
        
    }
}

