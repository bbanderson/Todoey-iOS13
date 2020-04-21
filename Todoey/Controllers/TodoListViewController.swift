//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var todoItems: Results<Item>?
    
    let realm = try! Realm()
    
    // 행을 선택하기 전까지는 nil이므로 optional 처리한다.
    var selectedCategory: Category? {
        didSet {
            loadItems()
            tableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let color = selectedCategory?.color {
            guard let navBar = navigationController?.navigationBar else {
                fatalError("Navigation controller does not exist.")
            }
            title = selectedCategory!.name

            if let navBarColor = UIColor(hexString: color) {
                navBar.backgroundColor = navBarColor
                navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
                if #available(iOS 11.0, *) {
                    navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)]
                } else {
                    // Fallback on earlier versions
                    navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)]
                }
                searchBar.tintColor = navBarColor
            }
            
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! SwipeTableViewCell
        //
        //        cell.delegate = self as SwipeTableViewCellDelegate
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
            
            
        } else {
            cell.textLabel?.text = "No Item Added"
        }
        
        if let beautifulColor = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
            cell.backgroundColor = beautifulColor
            cell.textLabel?.textColor = ContrastColorOf(beautifulColor, returnFlat: true)
        }
        
        
        
        
        
        return cell
    }
    
    //MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                    //                    realm.delete(item)
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        
    }
    
    
    //MARK: - Add New Items
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        
        var field = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Wanna master for..."
            field = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen once the user clicks the Add Item button on our UIAlert
            print("Success!")
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = field.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print(error)
                }
                
            }
            
            
            self.tableView.reloadData()
            
        }
        
        // 팝업에 버튼 입히기
        alert.addAction(action)
        
        
        
        // 팝업 창 보이기
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Model Manipulation Methods
    func saveItems(for item: Item) {
        
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    
    //MARK: - LoadItems
    func loadItems() {
        
        //        todoItems = realm.objects(Item.self)
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}

//MARK: - SearchBar

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
