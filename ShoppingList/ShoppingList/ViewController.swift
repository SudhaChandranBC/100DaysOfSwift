//
//  ViewController.swift
//  ShoppingList
//
//  Created by Chandran, Sudha on 25/12/21.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addButtonClicked(_ sender: Any) {
        let ac = UIAlertController(title: "Add Item",
                                   message: nil,
                                   preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Add",
                                         style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)


    }

    func submit(_ answer: String) {
        shoppingItems.append(answer)
        tableView.reloadData()
    }
    @IBAction func deleteButtonClicked(_ sender: Any) {
        shoppingItems.removeAll()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = shoppingItems[indexPath.row]
        return cell
    }
    
}

