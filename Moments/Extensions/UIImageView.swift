//
//  UIImageView.swift
//  Moments
//
//  Created by user226725 on 10/21/22.
//

import UIKit
	
extension UIImageView{
    //Make the image round
    func makeRound(){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
}

