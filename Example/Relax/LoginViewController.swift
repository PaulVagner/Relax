//
//  WebViewController.swift
//  InPassing
//
//  Created by Jo Albright on 7/21/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import Relax
import Inlinit

extension UIViewController: Inlinit { }

class LoginViewController: UIViewController, UIWebViewDelegate, Loginable {

    var loginWebView = UIWebView()
    
    var session: API!
    
    convenience init(session: API) { self.init(); self.session = session }
    
    override func viewWillAppear(animated: Bool) {
                
        guard let urlString = try? session.url(loginDetails.auth) else { return }
        guard let url = NSURL(string: urlString) else { return }
        
        view.addSubview(loginWebView)
        loginWebView.delegate = self
        loginWebView.frame = view.frame
        
        loginWebView.loadRequest(NSURLRequest(URL: url))
        
    }
    
    var loaded = false
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let loadedURL = request.URL?.absoluteString else { return true }
                
        if loadedURL.containsString("client_id") { return true }
        
        requestToken(loadedURL, endpoint: loginDetails.authCode, api: session) { [weak self] (success) -> Void in
            
            self?.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        return true
        
    }

}

class ViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.4) {
            
            self.navigationController?.navigationBar.barTintColor = UIColor(hue: 0, saturation: 0, brightness: 0.5, alpha: 1.0)
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let button = sender as? UIButton else { return }
        
        navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
        
        UIView.animateWithDuration(0.4) {
            
            self.navigationController?.navigationBar.barTintColor = button.backgroundColor

            
        }
        
        
    }
    
}

@IBDesignable class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    override func drawRect(rect: CGRect) {
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        
    }
    
}
