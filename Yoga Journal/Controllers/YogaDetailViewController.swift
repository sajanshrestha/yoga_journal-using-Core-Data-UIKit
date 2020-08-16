//
//  YogaDetailViewController.swift
//  Yoga Journal
//
//  Created by Sajan Shrestha on 8/13/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit

class YogaDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    var yoga: Yoga!
    
    var yogaModel: YogaModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        noteLabel.layer.borderColor = UIColor.lightGray.cgColor
        noteLabel.layer.borderWidth = 1.0
    
        if let imageData = yoga.image {
            imageView.image = UIImage(data: imageData)
        }
        
        durationLabel.text = "\(yoga.duration)s"
        nameLabel.text = yoga.name
        dateLabel.text = yoga.date?.getMediumFormatString()
        noteLabel.text = yoga.note

    }
    
    @IBAction func addImage(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true

        imagePicker.delegate = self

        present(imagePicker, animated: true)
    }
}

extension YogaDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            
            yogaModel.update(yoga, with: image.jpegData(compressionQuality: 0.8))
        }

        dismiss(animated: true)
    }
}
