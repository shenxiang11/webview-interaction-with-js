//
//  ViewController.swift
//  webview-interaction-with-js
//
//  Created by 沈翔 on 2021/5/6.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.load(URLRequest(url: URL(string: "https://www.baidu.com")!))
    }


}

