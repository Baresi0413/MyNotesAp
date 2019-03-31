//
//  ViewController.swift
//  MyNotesApp
//
//  Created by Francisco on 3/23/19.
//  Copyright © 2019 Francisco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var txtDes: UITextView!
    
    var EditNote:MyNotes?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if let note = EditNote{
            txtTitle.text = note.title
            txtDes.text = note.details
        }
    }

    @IBAction func buSave(_ sender: Any) {
        var newNote:MyNotes?
        if let note = EditNote{
            newNote = note
            
        }else{
        newNote = MyNotes(context: context)
        }
        newNote?.title = txtTitle.text
        newNote?.details = txtDes.text
        newNote?.date_save = NSDate() as Date
        do{
            ad.saveContext()
            txtTitle.text = ""
            txtDes.text = ""
        }catch{
            print("Cannot save")
        }
        
    }
    
    
    @IBAction func buBack(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        
    }
}

