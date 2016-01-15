//
//  InstagramCVC.swift
//  Relax
//
//  Created by Jo Albright on 1/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class InstagramCVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        InstagramAPI.session().start()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if InstagramAPI.session().authToken.isEmpty { login() } else { loadMedia() }
        
    }
    
    func login() {
        
        presentViewController(LoginViewController(session: InstagramAPI.session()), animated: true, completion: nil)

    }
    
    var photos: [AnyObject] = []
    
    func loadMedia() {
        
        let media = InstagramAPI.Endpoints.UsersMyMedia.endpoint
        
        InstagramAPI.session().request(media) {
         
            guard let items = $0.info?["data"] as? [[String:AnyObject]] else { return }
            
            self.photos = items.filter { $0["type"] as? String == "image" }
            self.collectionView?.reloadData()
            
        }
        
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return photos.count }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
    
        let photo = photos[indexPath.item]
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            
            guard let urlString = photo["images"]??["standard_resolution"]??["url"] as? String else { return }
            guard let url = NSURL(string: urlString) else { return }
            guard let data = NSData(contentsOfURL: url) else { return }
            
            let image = UIImage(data: data)
            
            dispatch_async(dispatch_get_main_queue(), {
                
                cell.imageView.image = image
                
            })
            
        }
    
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let wh = (collectionView.frame.width - 10) / 3
        return CGSize(width: wh, height: wh)
            
    }
    
    

}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
}
