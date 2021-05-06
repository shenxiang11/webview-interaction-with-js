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
//    lazy var userContentController = WKUserContentController()
//    lazy var configuaration: WKWebViewConfiguration = {
//        let conf = WKWebViewConfiguration()
//        conf.userContentController = userContentController
//        return conf
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                                
        let htmlFile = try! String(contentsOfFile: Bundle.main.path(forResource: "index", ofType: "html")!)
        webview.loadHTMLString(htmlFile, baseURL: nil)
    }
    
    // swift 执行 javascript
    @IBAction func handlePlayBtnTapped(_ sender: UIBarButtonItem) {
        webview.evaluateJavaScript("call1()") { result, error in
            print(type(of: result), result)
            print(type(of: error), error)
        }
    }
}

