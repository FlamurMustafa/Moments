//
//  SQLiteCommands.swift
//  Moments
//
//  Created by user226725 on 10/21/22.
//

import Foundation
import SQLite3
import SQLite

class SQLiteCommands{
    static var table = Table("contact")
    
    
    //expressions
    
    static let id = Expression<Int>("id")
    static let name = Expression<String>("name")
    static let description = Expression<String>("description")
    static let date = Expression<String>("date")
    static let photo = Expression<Data>("photo")
    
    //create table
    
    static func createTable(){
        guard let database = SQLiteDatabase.sharedInstance.database else{
            print("Datastore conection error")
            return
        }
        do{
            try database.run(table.create(ifNotExists:true){table in
                table.column(id, primaryKey:true)
                table.column(name, unique: true)
                table.column(description)
                table.column(date)
                table.column(photo)
            })
        } catch{
            print("Table already exists: \(error)")
        }
    }
    
    //insert Row
    static func insertRow(_ moment: Moment) -> Bool?{
        guard let database = SQLiteDatabase.sharedInstance.database else{
            print("Database connection error")
            return nil
        }
        do{
            try database.run(table.insert(name <- moment.name, description <- moment.description,date <- moment.date, photo <- moment.photo))
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Insert row failed: \(message), in \(String(describing: statement))")
            return false
        } catch let error{
            print("Insertion failed: \(error)")
            return false
        }
        return true
    }
    
    //update row
    static func updateRow(_ momentValues: Moment) -> Bool?{
        guard let database = SQLiteDatabase.sharedInstance.database else {
                   print("Datastore connection error")
                   return nil
               }
               
               // Extracts the appropriate contact from the table according to the id
               let moment = table.filter(id == momentValues.id).limit(1)
               
               do {
                   // Update the contact's values
                   if try database.run(moment.update(name <- momentValues.name, description <- momentValues.description, date <- momentValues.date, photo <- momentValues.photo)) > 0 {
                       print("Updated contact")
                       return true
                   } else {
                       print("Could not update contact: contact not found")
                       return false
                   }
               } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
                   print("Update row faild: \(message), in \(String(describing: statement))")
                   return false
               } catch let error {
                   print("Updation failed: \(error)")
                   return false
               }
    }
    
    static func presentRows() -> [Moment]? {
            guard let database = SQLiteDatabase.sharedInstance.database else {
                print("Datastore connection error")
                return nil
            }
            
            // Moment Array
            var momentArray = [Moment]()
            
            // Sorting data in descending order by ID
            table = table.order(id.desc)
            
            do {
                for moment in try database.prepare(table) {
                    
                    let idValue = moment[id]
                    let nameValue = moment[name]
                    let descriptionValue = moment[description]
                    let dateValue = moment[date]
                    let photoValue = moment[photo]
                    
                    // Create object
                    let momentObject = Moment(id: idValue, name: nameValue, description: descriptionValue, date: dateValue, photo: photoValue)
                    
                    // Add object to an array
                    momentArray.append(momentObject)
                    
                    print("id \(moment[id]), firstName: \(moment[name]), lastName: \(moment[description]), date: \(moment[date]), photo: \(moment[photo])")
                }
            } catch {
                print("Present row error: \(error)")
            }
            return momentArray
        }
    
    static func deleteRow(momentId: Int){
        guard let database = SQLiteDatabase.sharedInstance.database else{
            print("Datastore connection error")
            return
        }
        do{
            let moment = table.filter(id==momentId).limit(1)
            try database.run(moment.delete())
        } catch{
            print("delete row error")
        }
    }
}
