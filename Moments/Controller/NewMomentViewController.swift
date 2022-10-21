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
        createTable()
        photoImageView.makeRound()
        nameTextField.becomeFirstResponder()
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
        let uiImage = photoImageView.image ?? #imageLiteral(resourceName: "download")
        guard let photo = uiImage.pngData() else {return}
        
        let momentValues = Moment(id: id, name: name, description: description, date: date, photo: photo)
        createNewModel(momentValues)
        SQLiteCommands.presentRows()
    }
    
    private func createNewModel(_ momentValues:  Moment){
        let momentAddedToTable = SQLiteCommands.insertRow(momentValues)
        
        if momentAddedToTable == true {
            dismiss(animated: true, completion:nil)
            } else {
                showErro("Error", message: "This moment cannot be created")
            }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension NewMomentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //image tap gesture
    @IBAction func addImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage else{
            fatalError("Expected a dictionary")
        }
        
        photoImageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
}

extension NewMomentViewController: UITextFieldDelegate{
    //Should do date validation in the future
}

