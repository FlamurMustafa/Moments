//
//  SQLiteDatabase.swift
//  Moments
//
//  Created by user226725 on 10/21/22.
//

import Foundation
import SQLite

class SQLiteDatabase{
    static let sharedInstance = SQLiteDatabase()
    var database: Connection?
    
    private init(){
        //create connection
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("momentList")
                .appendingPathExtension("sqlite3")
            
            database = try Connection(fileUrl.path)
        } catch{
            print("Failed to create connection\(error)")
        }
    }
    
    //creating table
    func createTable(){
        SQLiteCommands.createTable()
    }
}
