//
//  DetailViewController.swift
//  Json-Codable
//
//  Created by Mahmoud Nasser on 30/11/2020.
//

import UIKit
import WebKit

class DetailViewController: UIViewController{

    var webView : WKWebView!
    var detailItem : Petition!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let html =
            """
                <html>
                    <head>
                            <meta name="viewport" content="width=device-width,intial-scale=1">
                            <style>
                                body{ font-size : 150%;}
                            </style>
                    </head>
                    <body>
                            \(detailItem.body)
                    </body>
                </html>
            """
        
        webView.loadHTMLString(html, baseURL: nil)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DetailViewController :WKNavigationDelegate{
    
}
