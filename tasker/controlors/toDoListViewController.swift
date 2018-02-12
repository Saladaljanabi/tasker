//
//  ViewController.swift
//  tasker
//
//  Created by sajad on 2/8/18.
//  Copyright © 2018 E.LAB. All rights reserved.
//

import UIKit
import CoreData
class toDoListViewController: UITableViewController{
    
    /// مصفوفه
    
    var itemArray = [Item]() /// السوالف الي تطلع بال  table view
    var selectedcatogray : Categray? {
        didSet{
            loaditems()

        }
    }
    ///in order to use user defullt
    
//  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    // for core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        
        super.viewDidLoad()
     
      
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //save the data
        
   
       
        
  
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
        
        
        ///to remove the data from our context is :-
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row) ///indexpath.row is the slected row
        
        
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
            let newItem = Item(context: self.context)
            newItem.title = textFiled.text!
            newItem.done = false
            newItem.percentCategory = self.selectedcatogray
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
    
    
    do {
        try context.save()
    }catch{
        print("eroor is oucuroe \(error)")
    }
    self.tableView.reloadData()
    }




        
        

    func loaditems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) { //<> means return
    let categorypredicat = NSPredicate(format: "percentCategory.name MATCHES %@", selectedcatogray!.name!)
        
        if let addtionpredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicat, addtionpredicate])
        }else{
            request.predicate = categorypredicat
            
        }
        
        
        
        
        
        
        
        
        
        
        
//
//        let compoundpredicat = NSCompoundPredicate(andPredicateWithSubPredicate: [categoryPredicate,predicate])
//
//        request.predicate = compoundpredicat
//
//
        
        
        
        
        
        
        
        
        
        do {
       itemArray = try context.fetch(request)
        }catch{
            print("Erro form featch \(error)")
        }
        tableView.reloadData()
        }

    
    
    }

//MARK: - search bar methods
extension toDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        //code for query
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) //[cd] means your array can search in [cd]
        
       
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loaditems(with: request, predicate: predicate)
        //loaditem line equivilant to this item:-
        
//        do {
//            itemArray = try context.fetch(request)
//        }catch{
//            print("Erro form featch \(error)")
//        }
        
        
        
        
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { ///when you write the table view load your search data and when you want to get to the normal tableview this method will return all your old data of cells
        if searchBar.text?.count == 0 {
            
            loaditems()
            
            DispatchQueue.main.async { //مثل الواسطه
             searchBar.resignFirstResponder()//remove the curser from the searchbar and remove the keyborad when search

            }

        }
    }
    
    
}

    



































