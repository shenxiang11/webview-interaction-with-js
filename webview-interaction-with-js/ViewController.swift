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
        
        webview.configuration.userContentController.add(self, name: "hahaha")
                                
        let htmlFile = Bundle.main.path(forResource: "index", ofType: "html")!
        webview.loadFileURL(URL(fileURLWithPath: htmlFile), allowingReadAccessTo: URL(fileURLWithPath: htmlFile))
    }
    
    // swift 执行 javascript
    @IBAction func handlePlayBtnTapped(_ sender: UIBarButtonItem) {
        webview.evaluateJavaScript("callJavascript()") { result, error in
            print(type(of: result), result)
            print(type(of: error), error)
        }
    }
    
    func showModal() {
        let alertController = UIAlertController(title: "恭喜", message: "你通过 js 调用了 swift 来展示一个 alert", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "确定", style: .default) {_ in
            self.dismiss(animated: true)
        }
        alertController.addAction(confirm)
        navigationController?.present(alertController, animated: true)
    }
    
    func showAction() {
        let alertController = UIAlertController(title: "恭喜", message: "你通过 js 调用了 swift 来展示一个action sheet", preferredStyle: .actionSheet)
        let confirm = UIAlertAction(title: "确定", style: .default) {_ in
            self.dismiss(animated: true)
        }
        alertController.addAction(confirm)
        navigationController?.present(alertController, animated: true)
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch "\(message.body)" {
        case "showAction":
            showAction()
        case "showModal":
            showModal()
        default:
            fatalError("未定义的行为")
        }
    }
}

