//
//  GitHubTVC.swift
//  Relax
//
//  Created by Jo Albright on 1/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class GitHubTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        GitHubAPI.session().start()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if GitHubAPI.session().authToken.isEmpty { login() } else { loadMyGists() }
        
    }
    
    func login() {
    
        presentViewController(LoginViewController(session: GitHubAPI.session()), animated: true, completion: nil)
        
    }

    var gists: [AnyObject] = []
    
    func loadMyGists() {
        
        GitHubAPI.session().request(GitHubAPI.Endpoints.GistsMe.endpoint) {
            
            print($0.info)
            // update tableview with list of gists
            
        }
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return gists.count }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("GistCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "gist name"
        
        return cell
        
    }

}
