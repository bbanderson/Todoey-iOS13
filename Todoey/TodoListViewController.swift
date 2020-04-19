//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
//    var itemArray = ["Study for AFPK", "Master iOS 13", "Go for GitHub", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3"]
    
    var itemArray = [Item]()
    
    var selectedCellList = [IndexPath]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let item1 = Item()
        item1.title = "1"
        itemArray.append(item1)
        let item2 = Item()
        item2.title = "2"
        itemArray.append(item2)
        let item3 = Item()
        item3.title = "3"
        itemArray.append(item3)
        let item4 = Item()
        item4.title = "4"
        itemArray.append(item4)
        let item5 = Item()
        item5.title = "5"
        itemArray.append(item5)
        let item6 = Item()
        item6.title = "6"
        itemArray.append(item6)
        let item7 = Item()
        item7.title = "7"
        itemArray.append(item7)
        let item8 = Item()
        item8.title = "8"
        itemArray.append(item8)
        let item9 = Item()
        item9.title = "9"
        itemArray.append(item9)
        let item10 = Item()
        item10.title = "10"
        itemArray.append(item10)
        let item11 = Item()
        item11.title = "11"
        itemArray.append(item11)
        let item12 = Item()
        item12.title = "12"
        itemArray.append(item12)
        let item13 = Item()
        item13.title = "13"
        itemArray.append(item13)
        let item14 = Item()
        item14.title = "14"
        itemArray.append(item14)
        let item15 = Item()
        item15.title = "15"
        itemArray.append(item15)
        let item16 = Item()
        item16.title = "16"
        itemArray.append(item16)
        let item17 = Item()
        item17.title = "17"
        itemArray.append(item17)
        let item18 = Item()
        item18.title = "18"
        itemArray.append(item18)
        let item19 = Item()
        item19.title = "19"
        itemArray.append(item19)
        let item20 = Item()
        item20.title = "20"
        itemArray.append(item20)
        let item21 = Item()
        item21.title = "21"
        itemArray.append(item21)
        let item22 = Item()
        item22.title = "22"
        itemArray.append(item22)
        let item23 = Item()
        item23.title = "23"
        itemArray.append(item23)
        let item24 = Item()
        item24.title = "24"
        itemArray.append(item24)
        let item25 = Item()
        item25.title = "25"
        itemArray.append(item25)
        let item26 = Item()
        item26.title = "26"
        itemArray.append(item26)
        let item27 = Item()
        item27.title = "27"
        itemArray.append(item27)
        let item28 = Item()
        item28.title = "28"
        itemArray.append(item28)
        let item29 = Item()
        item29.title = "29"
        itemArray.append(item29)
        let item30 = Item()
        item30.title = "30"
        itemArray.append(item30)
//        defaults.set(itemArray, forKey: "ToDoArrayList")
//        if let items = defaults.array(forKey: "ArrayModel") as? [Item] {
//            itemArray = items
//
////            itemArray = items
//        }
//        defaults.set(itemArray, forKey: "ArrayModel")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        print(indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if let _ = selectedCellList.firstIndex(of: indexPath) {
            itemArray[indexPath.row].done.toggle()
            cell.accessoryType = .checkmark
        } else {
            itemArray[indexPath.row].done.toggle()
            cell.accessoryType = .none
        }
        print(itemArray[indexPath.row].done)
        return cell
    }
    
    //MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)!
//        let cell = itemArray[indexPath.row]
//        print(cell.textLabel?.text ?? "nil")
        
//        print(tableView.allowsSelection.toggle())
        
//
//    var isDone = itemArray[indexPath.row].done
        
        
        if let index = selectedCellList.firstIndex(of: indexPath) {
            selectedCellList.remove(at: index)
        } else {
            selectedCellList.append(indexPath)
        }
        
        
//        print(indexPath.row)
//        print(itemArray[indexPath.row].title)
//        if itemArray[indexPath.row].done == true {
////            cell.accessoryType = .none
//            itemArray[indexPath.row].done.toggle()
//            print(itemArray[indexPath.row].done)
//        } else {
////            cell.accessoryType = .checkmark
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//            itemArray[indexPath.row].done.toggle()
//            print(itemArray[indexPath.row].done)
//        }
        
        
//        if !selectedCell.done {
//            selectedCell.done = false
//            cell.accessoryType = .none
//
//        } else {
//
//            selectedCell.done = true
//            cell.accessoryType = .checkmark
//
//        }
//
        
        
//        if cell.accessoryType == .none {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
//        tableView.deselectRow(at: indexPath, animated: true)

    }

    
    //MARK: - Add New Items
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Wanna master for..."
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen once the user clicks the Add Item button on our UIAlert
            print("Success!")
            
//            let item = Item(title: alert.textFields?[0].text ?? "Nil")
            
            let userInput = alert.textFields?[0].text ?? "Nothing."
            
            let item = Item()
            item.title = userInput
            
            self.itemArray.append(item)
//            self.defaults.set(self.itemArray, forKey: "ArrayModel")
            
//            self.itemArray.append(alert.textFields?[0].text ?? "")
//            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
            
        }
        
        // 팝업에 버튼 입히기
        alert.addAction(action)
        
        
        
        // 팝업 창 보이기
        present(alert, animated: true, completion: nil)
    }
    
}



