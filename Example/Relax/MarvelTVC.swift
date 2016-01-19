//
//  MarvelTVC.swift
//  Relax
//
//  Created by Jo Albright on 1/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class MarvelTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MarvelAPI.session().start()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        MarvelAPI.session().request(MarvelAPI.Endpoints.Characters.endpoint) {
                        
            guard let data = $0.info?["data"] as? [String:AnyObject] else { return }
            
            self.characters = data["results"] as? [[String:AnyObject]] ?? []
            self.tableView.reloadData()
            
        }
        
    }
    
    var characters: [AnyObject] = []
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return characters.count }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CharacterCell", forIndexPath: indexPath) as! CharacterCell
        
        let character = characters[indexPath.row]
        
        cell.characterNameLabel?.text = character["name"] as? String
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            
            guard let path = character["thumbnail"]??["path"] as? String else { return }
            guard let ext = character["thumbnail"]??["extension"] as? String else { return }
            guard let url = NSURL(string: path + "." + ext) else { return }
            guard let data = NSData(contentsOfURL: url) else { return }
            
            let image = UIImage(data: data)
            
            dispatch_async(dispatch_get_main_queue(), {
                
                cell.characterImageView?.image = image
                
            })
            
        }
        
        return cell
    
    }

}

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    override func prepareForReuse() {
        
        characterImageView.image = nil
        
    }
    
}
