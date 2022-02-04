//
//  TrailerViewController.swift
//  Flix
//
//  Created by Dhiaa Bantan on 2/3/22.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var movie: [String: Any]!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieID = movie["id"]
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let results = dataDictionary["results"] as! [[String: Any]]
                
                let key = results[0]["key"] as! String
                
                let myURL = URL(string: "https://www.youtube.com/watch?v=\(key)")
                let myRequest = URLRequest(url: myURL!)
                self.webView.load(myRequest)
                
            }
        }
        task.resume()
    
    }
}
