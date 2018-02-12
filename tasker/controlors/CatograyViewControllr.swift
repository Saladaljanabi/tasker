//
//  CatograyViewControllr.swift
//  tasker
//
//  Created by sajad on 2/11/18.
//  Copyright © 2018 E.LAB. All rights reserved.
//

import UIKit
import CoreData
class CatograyViewControllr: UITableViewController {

    var Categroys = [Categray]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext




    override func viewDidLoad() {
        super.viewDidLoad()


      loadCatograys()

    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categroys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Categoray Cell", for: indexPath)

        cell.textLabel?.text = Categroys[indexPath.row].name



        return cell
    }
    //MARK: - TableView Delegates Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
        
        
        
        
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinatioVC = segue.destination as! toDoListViewController
        if let indexpath = tableView.indexPathForSelectedRow {
            
            destinatioVC.selectedcatogray = Categroys[indexpath.row]
            
            
            
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - data Minuplation Methods
    func saveCatorgays() {

        do {
            try context.save()

        }catch{
            print("there is some error \(error)")
        }

       tableView.reloadData()

    }
    func loadCatograys() {

        let request : NSFetchRequest<Categray> = Categray.fetchRequest()
        do{

         Categroys = try context.fetch(request)
        }catch{
            print("error\(error)")
        }

        tableView.reloadData()
    }
//
//
//    //MARK: - Add New Categroies
//
    @IBAction func AddButtonPresed(_ sender: UIBarButtonItem) {
        var textFiled = UITextField()
        let alert = UIAlertController(title: "add a new catogray", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add", style: .default) { (action) in

            let newCatogry = Categray(context: self.context)
            newCatogry.name = textFiled.text!
            self.Categroys.append(newCatogry)


           self.saveCatorgays()


            
            self.tableView.reloadData()
        }
//
//
        alert.addAction(action)
        alert.addTextField { (filed) in
            textFiled = filed
            textFiled.placeholder = "add a new catogry"
        }

    present(alert, animated: true, completion: nil)

    }
//
//






}

