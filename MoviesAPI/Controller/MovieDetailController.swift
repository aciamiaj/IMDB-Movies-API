//
//  MovieDetailController.swift
//  MoviesAPI
//
//  Created by user232105 on 4/18/23.
//

import Foundation
import UIKit

class MovieDetailController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
   // @IBOutlet weak var imdbRatingLabel: UILabel!
    var movie : SearchResponse?
    

    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.black
        titleLabel.textColor = UIColor.white
        descriptionLabel.textColor = UIColor.white
        //imdbRatingLabel.textColor = UIColor.yellow
        
        if let movie = movie {
            titleLabel?.text = movie.title
            descriptionLabel.text = movie.description
           // imdbRatingLabel.text = movie.IMDbRating
            
            if let url = URL(string: movie.image) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)
                            // Display the image in an UIImageView
                            self.movieImage.image = image
                        }
                    }
                }.resume()
            }

        }
        
        
        
    }
}

