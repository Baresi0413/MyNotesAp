//
//  VCListNotes.swift
//  MyNotesApp
//
//  Created by Francisco on 3/23/19.
//  Copyright © 2019 Francisco. All rights reserved.
//

import UIKit
import CoreData

class VCListNotes: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var listNotes =  [MyNotes]()
    
    
    
    @IBOutlet weak var tvNotesList: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNotes()
            tvNotesList.delegate = self
            tvNotesList.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TVCNotes =  tableView.dequeueReusableCell(withIdentifier: "CellNote", for:indexPath) as! TVCNotes
        cell.SetNotes(note: listNotes[indexPath.row])
        cell.buDelete.tag = indexPath.row
        cell.buDelete.addTarget(self, action: #selector(buDeletePress(_:)), for: .touchUpInside)
        
        
        
        cell.buEdit.tag = indexPath.row
        cell.buEdit.addTarget(self, action: #selector(buEditPress(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func buDeletePress(_ sender:UIButton){
        print("index  \(sender.tag)")
        context.delete(listNotes[sender.tag])
        loadNotes()
    }
    
    
    
    @objc func buEditPress(_ sender:UIButton){
       performSegue(withIdentifier: "EditOrAddSegway", sender: listNotes[sender.tag])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "EditOrAddSegway"{
            if let AddOrEdit = segue.destination as? ViewController {
                if let myNote = sender as? MyNotes{
                    AddOrEdit.EditNote = myNote
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func buAdd(_ sender: Any) {
        performSegue(withIdentifier: "EditOrAddSegway", sender: nil)
        
    }
    
    
    

    func loadNotes(){
        let fetchRequest:NSFetchRequest<MyNotes> = MyNotes.fetchRequest()
        do{
            listNotes = try context.fetch(fetchRequest)
            tvNotesList.reloadData()
        }catch{
            print("cannot read from database")
        }
        
        
        }

}
