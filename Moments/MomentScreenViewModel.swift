//
//  MomentScreenViewModel.swift
//  Moments
//
//  Created by user226725 on 10/21/22.
//

import Foundation

class MomentScreenViewModel{
    
    private var momentArray = [Moment]()
    
    func connectToDatabase(){
        _ = SQLiteDatabase.sharedInstance
    }
    
    func loadDataFromSQLiteDatabase()
    {
        momentArray = SQLiteCommands.presentRows() ?? []
    }
    
    func numberOfRowsInSection (section: Int)->Int{
        if momentArray.count != 0{
            return momentArray.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Moment{
        return momentArray[indexPath.row]
    }
    
}
