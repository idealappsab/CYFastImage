//
//  UIImageView+FastImage.swift
//  CYFastImage
//
//  Created by jason on 14-6-17.
//  Copyright (c) 2014 chenyang. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageURL(url: NSString!, placeHolderImage: UIImage!) {
        if placeHolderImage {
            self.image = placeHolderImage
        } else {
            self.image = nil
        }
        
        
        if url {
            CYFastImage.sharedImageManager.cancel(self)
            
            CYFastImage.sharedImageManager.getImage(url, delegate: self) {
                [weak self]
                (image: UIImage!, url: String!) -> Void in
                if self != nil {
                    if image {
                        if NSThread.isMainThread() {
                            self!.image = image
                            self!.setNeedsLayout()
                        } else {
                            dispatch_async(dispatch_get_main_queue()){
                                self!.image = image
                                self!.setNeedsLayout()
                            }
                        }
                    }
                }
            }
        }
    }
}