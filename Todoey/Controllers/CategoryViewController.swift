//
//  CategoryViewController.swift
//  Todoey
//
//  Created by HYUNHONG BYUN on 2020/04/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var category = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return category.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = category[indexPath.row].name
        cell.textLabel?.text = item
        return cell
    }
    //MARK: - Add New Category
    @IBAction func AddBtnPressed(_ sender: UIBarButtonItem) {
        
        var field = UITextField()
        
        let alert = UIAlertController(title: "카테고리 추가", message: "추가해보세요", preferredStyle: .alert)
        let action = UIAlertAction(title: "추가", style: .default) { (action) in

            let cellItem = Category(context: self.context)
            cellItem.name = field.text!
            
            self.category.append(cellItem)
            self.save()
        }
        alert.addTextField { (alertTextField) in
            field = alertTextField
            field.placeholder = "카테고리를 설정하세요."
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
                
    }
    
    //MARK: - TableViewDataSourceMethods
    func save() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }
    
    func loadData(with request:  NSFetchRequest<Category> = Category.fetchRequest()) {
                
        do {
            category = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    //MARK: - TableView Delegate Methos

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = category[indexPath.row]

        }
        
    }

}
