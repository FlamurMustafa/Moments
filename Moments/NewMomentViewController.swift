//
//  NewMomentViewController.swift
//  Moments
//
//  Created by user226725 on 10/21/22.
//

import UIKit

class NewMomentViewController: UIViewController {

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var viewModel: NewMomentViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //
    private func createTable(){
        let database = SQLiteDatabase.sharedInstance.createTable()
    }

    @IBAction func saveButtonClicked(_ sender: Any) {
        let id: Int = 0
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let date = dateTextField.text ?? ""
        let photoImage = photoImageView.image ?? #imageLiteral(resourceName: "download")
        
        guard let photo 
    }
}

