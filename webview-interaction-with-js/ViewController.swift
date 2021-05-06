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
        
        webview.configuration.userContentController.add(self, name: "showAlert")
        webview.configuration.userContentController.add(self, name: "showAction")
                                
        let htmlFile = Bundle.main.path(forResource: "index", ofType: "html")!
//        webview.loadHTMLString(try! String(contentsOfFile: htmlFile), baseURL: nil)
        webview.loadFileURL(URL(fileURLWithPath: htmlFile), allowingReadAccessTo: URL(fileURLWithPath: htmlFile))
    }
    
    // swift 执行 javascript
    @IBAction func handlePlayBtnTapped(_ sender: UIBarButtonItem) {
        webview.evaluateJavaScript("callJavascript()") { result, error in
            print(type(of: result), result)
            print(type(of: error), error)
        }
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "确定", style: .default) {_ in
            self.dismiss(animated: true)
        }
        alertController.addAction(confirm)
        navigationController?.present(alertController, animated: true)
    }
    
    func showAction(_ message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .actionSheet)
        let confirm = UIAlertAction(title: "确定", style: .default) {_ in
            self.dismiss(animated: true)
        }
        alertController.addAction(confirm)
        navigationController?.present(alertController, animated: true)
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(type(of: message.body), (message.body as? NSDictionary)?["a"])
        switch "\(message.name)" {
        case "showAction":
            showAction(message.body as? String ?? "")
        case "showAlert":
            showAlert(message.body as? String ?? "")
        default:
            fatalError("未定义的行为")
        }
    }
}

