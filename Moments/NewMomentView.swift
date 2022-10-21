//
//  NewMoment.swift
//  Moments
//
//  Created by user226725 on 10/21/22.
//

import UIKit

class NewMomentViewModel {
    
    private var momentValues: Moment?
    
    let id: Int?
    let name: String?
    let description: String?
    let date: String?
    let photo: UIImage?
    
    
    init(momentValues: Moment?){
        self.momentValues = momentValues
        
        self.id = momentValues?.id
        self.name = momentValues?.name
        self.description = momentValues?.description
        self.date = momentValues?.date
        self.photo = UIImage(data: momentValues!.photo)
        
    }
}
