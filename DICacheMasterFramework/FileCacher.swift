//
//  FileCacher.swift
//  DICacheMasterFramework
//
//  Created by MACBOOK PRO on 25/04/2019.
//  Copyright © 2019 DAO Ibrahim. All rights reserved.
//

import UIKit

import Alamofire
import Lightbox
import Kingfisher

public class FileCacher: UIView, LightboxControllerPageDelegate {
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Action methods
    public static func initCache(memoryCacheSizeInMega:Int,imageNumberLimit:Int, expirationTimeInSecond:Int){
        let cache = ImageCache.default
        // Limit memory cache size to 300 MB.
        cache.memoryStorage.config.totalCostLimit = memoryCacheSizeInMega * 1024 * 1024
        
        // Limit memory cache to hold 150 images at most.
        cache.memoryStorage.config.countLimit = imageNumberLimit
        
        cache.memoryStorage.config.expiration = .seconds(TimeInterval(expirationTimeInSecond*60))
        
    }
    public static func cacheImage(url:String!,uiImageView:UIImageView)->Bool{
        let theUrl = URL(string: url)
        var success:Bool=false
        uiImageView.kf.indicatorType = .activity
        uiImageView.kf.setImage(with: theUrl, options: [.transition(.fade(0.2))]){ result in
            // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
            switch result {
            case .success(let value):
                print(value.image)
                print(value.cacheType)
                SweetAlert().showAlert("Good job!", subTitle: "Image Cached Succefully!", style: AlertStyle.success)
                // The source object which contains information like `url`.
                print(value.source)
                success=true
                
            case .failure(let error):
                if let errorMessage=error.errorDescription{
                    SweetAlert().showAlert("Oops!", subTitle: "Something went wrong! "+errorMessage, style: AlertStyle.error)
                }
                else {SweetAlert().showAlert("Oops!", subTitle: "Something went wrong! Unknown error", style: AlertStyle.error)}
                print(error) // The error happens
                success=false
            }
        }
        return success
        
    }
    
    public static func cancelDownload(uiImageView:UIImageView){
        uiImageView.kf.cancelDownloadTask()
    }
    
    public static func didCacheExist(url:String)->Bool{
        let cache = ImageCache.default
        return cache.isCached(forKey: url)
    }
    
    
    public static func fetchImage(url:String, uiImageView:UIImageView){
        let cache = ImageCache.default
        uiImageView.kf.indicatorType = .activity
        let cached = cache.isCached(forKey: url)
        
        if(cached){
        cache.retrieveImage(forKey: url) { result in
            switch result {
            case .success(let value):
                print(value.cacheType)
                SweetAlert().showAlert("Good job!", subTitle: "Cached image succefully shown!", style: AlertStyle.success)
                
                // If the `cacheType is `.none`, `image` will be `nil`.
                print(value.image)
                uiImageView.image=value.image
                
            case .failure(let error):
                SweetAlert().showAlert("Oops!", subTitle: "It look like there is no cache from this url!", style: AlertStyle.error)
                print(error)
            }
        }
        }
        else {
            SweetAlert().showAlert("Oops!", subTitle: "It look like there is no cache from this url!", style: AlertStyle.error)
        }
    }
    public static func deleteCache(url:String!)->Bool{
        //let url1 = "http://images.coveralia.com/autores/fotos/silento74838.jpg"
        // remove
        //check first is image is cached
        let cache = ImageCache.default
        let cached = cache.isCached(forKey: url)
        var success:Bool=false
        
        if(cached){
            print("show the dialog")
        SweetAlert().showAlert("Wait a minute!", subTitle: "Do you really want to delete this url from cache!", style: AlertStyle.warning, buttonTitle:"Cancel", buttonColor:UIColor(red: 0.9, green: 0, blue: 0, alpha: 1.0) , otherButtonTitle:  "Yes, delete it!", otherButtonColor: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                //println("Cancel Button  Pressed")
                SweetAlert().showAlert("Canceled!", subTitle: "You canceled the deletion! Great", style: AlertStyle.success)
                success=false
                print("canceled, and set to false \(success)")
            }
            else {
                let cache = ImageCache.default
                cache.removeImage(forKey: url)
                SweetAlert().showAlert("Deleted!", subTitle: "The cache has been permenantly deleted!", style: AlertStyle.success)
                success=true
                print("deleted, and set to true \(success)")
            }
        }
        }
        else {
            SweetAlert().showAlert("Oops!", subTitle: "It look like there is no cache from this url!", style: AlertStyle.error)
        }
        print("returning \(success)")
        return success
    }
    
    public static func displayImageGrid(vc:UIViewController, API_URL:String){
        
        var dt = [data]()
        var images=[LightboxImage]()
        var i=0;
        Alamofire.request(API_URL).responseJSON { response in
            //now here we have the response data that we need to parse
            let json = response.data
            do{
                //created the json decoder
                let decoder = JSONDecoder()
                
                //using the array to put values
                dt = try decoder.decode([data].self, from: json!)
                
                print("json="+String(json!.count))
                //printing all the hero names
                for data in dt{
                    print("i="+String(i)+String(json!.count))
                    if let download = data.links?.download {
                        
                        print(" and url="+download)
                        print(download+" added")
                        images.append(LightboxImage(imageURL: URL(string: download)!,
                                                    text: data.id!))
                        
                        if(i==9){
                            
                            //print(json?.underestimatedCount)
                            print("adding completed; must show now")
                            //DispatchQueue.async(DispatchQueue.main(), refresh)
                            let controller = LightboxController(images: images)
                            //controller.pageDelegate =
                            //controller.dismissalDelegate = self
                            LightboxConfig.InfoLabel.ellipsisText = "Show more"
                            // Use dynamic background.
                            controller.dynamicBackground = true
                            // Hide the footerView
                            controller.footerView.isHidden = true;
                            //controller.pageDelegate=lightboxController(self)
                            //controller.dismissalDelegate=
                            // Present your controller.
                            vc.present(controller, animated: true, completion: nil)
                        }
                        i+=1
                    }
                    //i+=1
                }
                
            }catch let err{
                print(err)
            }
        }
        
        
    }
    
    
    
    public static func cacheJSON(url:String){
        
    }
    
    public static func cacheXML(url:String){
        
    }
    
    public static func detectFileType(url:String){
        
    }
    
    public static func performCacheWithoutWorryingAboutAnyDetails(){
        
    }
    
    //LightBox delegate methods
    public func lightboxControllerWillDismiss(_ controller: LightboxController) {
        print("dismissed")
    }
    
    
    public func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        print(page)
    }
    

    struct data : Codable{
        let id:String?
        let created_at: String?
        let width: Int?
        let height: Int?
        let color: String?
        let likes: Int?
        let liked_by_user: Bool?
        let links:image?
        //let user:Dictionary<String, Dictionary<String,String>>?
        let urls:Dictionary<String, String>?
        //let categories:Dictionary<String, String>?
        //let bio: String?
    }
    
    struct image : Codable{
        //let self:String?
        let html: String?
        let download: String?
    }
}
extension UIViewController: LightboxControllerPageDelegate {
    
    public func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        print(page)
    }
}
