//
//  FurnitureDetailViewController.swift
//  HomeFurniture
//
//  Created by Eliana Boado on 3/5/19.
//  Copyright © 2019 Eliana Boado. All rights reserved.
//


import UIKit;

class FurnitureDetailViewController: UIViewController,
    UINavigationControllerDelegate,   //p. 683, step 2, bullet 2
    UIImagePickerControllerDelegate {
    
    var furniture: Furniture?;
    
    @IBOutlet weak var choosePhotoButton: UIButton!;
    @IBOutlet weak var furnitureTitleLabel: UILabel!;
    @IBOutlet weak var furnitureDescriptionLabel: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        updateView();
    }
    
    func updateView() {
        guard let furniture: Furniture = furniture else {return;}
        if let imageData: Data = furniture.imageData,
            let image: UIImage = UIImage(data: imageData) {
            choosePhotoButton.setTitle("", for: .normal);
            choosePhotoButton.setImage(image, for: .normal);
        } else {
            choosePhotoButton.setTitle("Choose Image", for: .normal);
            choosePhotoButton.setImage(nil, for: .normal);
        }
        
        furnitureTitleLabel.text = furniture.name;
        furnitureDescriptionLabel.text = furniture.description;
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: UIButton) {
        let imagePicker: UIImagePickerController = UIImagePickerController(); //p. 683, step 2, bullet 1
        imagePicker.delegate = self;   //p. 683, step 2, bullet 2

        let alertController: UIAlertController = UIAlertController( //p. 682, step 1, bullet 2
            title: "Choose Image Source",
            message: "Where do you want to get an image from?",
            preferredStyle: .actionSheet
        );
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {   //p. 683, step 2, bullet 4
            //p. 682, step 1, bullet 4
            let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) {(action: UIAlertAction) in
                imagePicker.sourceType = .camera;
                self.present(imagePicker, animated: true);
            }
            alertController.addAction(cameraAction);
        }
        
        if UIImagePickerController.isSourceTypeAvailable (.photoLibrary) {   //p. 683, step 2, bullet 4
            //p. 682, step 1, bullet 4
            let photoLibraryAction: UIAlertAction = UIAlertAction(title: "Photo Library", style: .default) {(action: UIAlertAction) in
                imagePicker.sourceType = .photoLibrary;
                self.present(imagePicker, animated: true);
            }
            alertController.addAction(photoLibraryAction);
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel); //p. 682, step 1, bullet 3
        alertController.addAction(cancelAction);
        
        alertController.popoverPresentationController?.sourceView = sender;
        present(alertController, animated: true);   //p. 682, step 1, bullet 5
    }
    
    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {   //page 684, step 3, bullet 1
        var activityItems: [Any] = [Any]();
        
        guard let furniture: Furniture = furniture else {
            return;
        }
        
        if let data: Data = furniture.imageData,
            let image: UIImage = UIImage(data: data) {
            activityItems.append(image);
        }
        
        if !furniture.description.isEmpty {
            activityItems.append(description);
        }
        
        guard !activityItems.isEmpty else {
            return;
        }

        let activityController: UIActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil);
        
        //UIBarButtonItem is not a UIView.
        //activityController.popoverPresentationController?.sourceView = sender;
        
        present(activityController, animated: true);
    }
    
    // MARK: - UIImagePickerControllerDelegate
    // Page 683, step 2, bullet 5.
    // First column of dictionary should be of type UIImagePickerController.InfoKey
    // UIImagePickerControllerOriginalImage renamed UIImagePickerController.InfoKey.originalImage
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        //page 684, step 2, bullet 7
        guard let image: UIImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            fatalError("could not get original image");
        }
        
        guard let data: Data = image.pngData() else {
            fatalError("UIImagePNGRepresentation() returned nil");
        }
        
        guard furniture != nil else {
            fatalError("furniture = nil");
        }
        furniture?.imageData = data;   //page 684, step 2, bullet 8
        
        dismiss(animated: true, completion: {
            self.updateView();   //page 684, step 2, bullet 8
        });
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true);   //page 684, step 2, bullet 6
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
