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
    let defult = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = item()
        newItem.title = "اشرب"
        itemArray.append(newItem)
        
        let newItem2 = item()
        newItem2.title = "ابلع"
        itemArray.append(newItem2)
        
        
        
        let newItem3 = item()
        newItem3.title = "اضرب"
        itemArray.append(newItem3)
        
        
        
        
        
        ///to retrive the data
        if let item = defult.array(forKey: "toDoListArray") as? [item] {

            itemArray = item


        }
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
           tableView.reloadData()
        
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
            self.defult.setValue(self.itemArray, forKey: "toDoListArray")
            self.tableView.reloadData() ///refresh the table view to add the new cell
        }
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "create new item"
            textFiled = alertTextFiled
            
        }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
    }
    
    }


