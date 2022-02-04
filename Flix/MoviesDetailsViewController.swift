//
//  MoviesDetailsViewController.swift
//  Flix
//
//  Created by Dhiaa Bantan on 2/2/22.
//

import UIKit
import AlamofireImage

class MoviesDetailsViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        posterView.af.setImage(withURL: posterURL!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string:  "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af.setImage(withURL: backdropURL!)
        
        // Tap Gesture Config:
        
        // The didTap: method will be defined in Step 3 below.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))

        // Optionally set the number of required taps, e.g., 2 for a double click
        tapGestureRecognizer.numberOfTapsRequired = 1

        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        posterView.isUserInteractionEnabled = true
        posterView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    

    
    // MARK: - Navigation
     
     @objc func didTap(sender: UITapGestureRecognizer) {
         
         sender.location(in: posterView)
         performSegue(withIdentifier: "trailerSegue2", sender: self)
         
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         // Find the selected movie:
         
         let detailsViewController = segue.destination as! TrailerViewController
         detailsViewController.movie = movie
     }

}
