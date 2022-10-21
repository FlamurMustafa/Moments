//
//  MomentScreenTableViewController.swift
//  Moments
//
//  Created by user226725 on 10/21/22.
//

import UIKit

class MomentScreenTableViewController: UITableViewController {

    private var viewModel = MomentScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Moments"
        //connect to dtabase
        
        viewModel.connectToDatabase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
        tableView.reloadData()
    }
    
    private func loadData(){
        viewModel.loadDataFromSQLiteDatabase()
    }

    
    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let object = viewModel.cellForRowAt(indexPath: indexPath)
        
        if let momentCell = cell as? MomentTableViewCell{
            momentCell.setCellWithValues(object)
        }
        // Configure the cell...

        return cell
    }
    //delete cell from table
    	
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let moment = viewModel.cellForRowAt(indexPath: indexPath)
                
                // Delete contact from database table
                SQLiteCommands.deleteRow(momentId: moment.id)
                
                // Updates the UI after delete changes
                self.loadData()
                self.tableView.reloadData()
            }
        }
    //passes selected contact from table cell to edit NewMomenViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact"{
            guard let newMomentVC = segue.destination as?
                    NewMomentViewController else {return}
            guard let selectedMomentCell = sender as?
                    MomentTableViewCell else {return}
            if let indexPath = tableView.indexPath(for: selectedMomentCell){
                let selectedMoment = viewModel.cellForRowAt(indexPath: indexPath)
                viewModel.cellForRowAt(indexPath: indexPath)
                newMomentVC.viewModel = NewMomentViewModel(momentValues: selectedMoment)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
