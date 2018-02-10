//
//  ViewController.swift
//  tasker
//
//  Created by sajad on 2/8/18.
//  Copyright © 2018 E.LAB. All rights reserved.
//

import UIKit

class toDoListViewController: UITableViewController {
    
    /// مصفوفه
    
    var itemArray = [item]() /// السوالف الي تطلع بال  table view
///in order to use user defullt
    
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //save the data
        
    
       
        
        
loaditems()
  
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    
    
    //MARK - tableview datasource methods:- التيبل فيو مالتك طريقه تكوينها
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row] ////looooooook
        
        cell.textLabel?.text = item.title
        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none /// ? if it is true the set it to .checkmark
        ///(: if its not true)
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else{
//            cell.accessoryType = .none
//        }
//
        
        
        
        
        return cell
    }
    
    
    ///MARK - TableView Deleget Methods this method detect which row was selected
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row]) ///تطبع الكلمه الي انت واكف عليها بالتيبل فيو
        
        ///to make a mark when  we select any cell in the table view -
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //! means oppesite(if the done is true it makes it false, if it false it make it true)this line replcae those 3 lines
//
//        if itemArray[indexPath.row].done == false {
//
//            itemArray[indexPath.row].done = true
//        }else {
//            itemArray[indexPath.row].done = false
//        }
//
//
//
        
        
        
        ///to remove the check box when we hit the cell again - (dont use)
        
//
//        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//
//        }
           saveitems()
        
        /// to remove gray highlighting when we select a cell -
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
        
        
    }
    
    ///MARK - add new items
   /// when you hit the plus barbuttom and to add items to your table view
    @IBAction func addButtomPressed(_ sender: UIBarButtonItem) {
        
        var textFiled = UITextField() ///لوكل فاريبل علمود يجيب معلومات ابين ال٢ كلوشر
        
        let alert = UIAlertController(title: "add a new task", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            
            //what will happen when the user hit the add buttom on the uialert
            let newItem = item()
            newItem.title = textFiled.text!
            
            self.itemArray.append(newItem) ////add to the array what ever the user type in the box(alert)
            
            let encoder = PropertyListEncoder()
            
        self.saveitems()
            
            
            self.tableView.reloadData() ///refresh the table view to add the new cell
        }
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "create new item"
            textFiled = alertTextFiled
            
        }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
    }
    
  


func saveitems() {
    
    let encoder = PropertyListEncoder()
    
    do {
        let data = try encoder.encode(itemArray)
        try data.write(to: dataFilePath!)
    }catch{
        print("error encoding item array, \(error)")
    }
    self.tableView.reloadData()
    }




        
        
        
    func loaditems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([item].self, from: data)
            }catch{
                
                print("erorr \(error)")
            }
            
            
            
            
        }
    }

    
   
    
    



}































