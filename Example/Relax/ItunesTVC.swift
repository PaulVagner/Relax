//
//  ItunesTVC.swift
//  Relax
//
//  Created by Jo Albright on 1/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class ItunesTVC: UITableViewController {
    
    var items: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ItunesAPI.session().start()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        search("daft+punk", entity: "album")
        
    }
    
    func search(term: String, entity: String) {
        
        var search = ItunesAPI.Endpoints.Search.endpoint
        
        search.parameters = ["term" : term, "entity": entity]
        
        ItunesAPI.session().request(search) {
            
            guard let info = $0.info as? [String:AnyObject] else { return }
            
            self.items = info["results"] as? [[String:AnyObject]] ?? []
            self.tableView.reloadData()
            
        }

        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return items.count }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EntityCell", forIndexPath: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item["collectionName"] as? String
        cell.detailTextLabel?.text = item["artistName"] as? String
        
        return cell
        
    }

}
