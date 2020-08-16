//
//  AddYogaViewController.swift
//  Yoga Journal
//
//  Created by Sajan Shrestha on 8/13/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit

class AddYogaViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var yogaModel: YogaModel!
    
    var delegate: YogaDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpInterface()
    }
    
    private func setUpInterface() {
        
        noteTextView.layer.borderColor = UIColor.gray.cgColor
        noteTextView.layer.cornerRadius = 8.0
        noteTextView.layer.borderWidth = 1.0
        
        addButton.layer.cornerRadius = 8.0
        cancelButton.layer.cornerRadius = 8.0
    }
    
    @IBAction func addYoga(_ sender: UIButton) {
        
        guard let name = nameTextField.text,
            let duration = Int16(durationTextField.text!),
            let note = noteTextView.text
            else { return }
        
        yogaModel.addYoga(name: name, duration: duration, date: Date(), note: note)
        
        delegate.didAddYoga()
        
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
