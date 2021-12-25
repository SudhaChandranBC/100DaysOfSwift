//
//  ViewController.swift
//  Project7
//
//  Created by Chandran, Sudha on 25/12/21.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var urlString = String()


    override func viewDidLoad() {
        super.viewDidLoad()
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }

        performSelector(inBackground: #selector(fetchJSON), with: nil)

//        let urlString: String
//
//        if navigationController?.tabBarItem.tag == 0 {
//            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
//        } else {
//            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
//        }
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            [weak self] in
//            if let url = URL(string: urlString) {
//                if let data = try? Data(contentsOf: url) {
//                    // we're OK to parse!
//                    self?.parse(json: data)
//                    return
//                }
//            }
//            self?.showError()
//        }


    }

    @objc func fetchJSON() {

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }

//        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }


    @objc func showError() {
        let ac = UIAlertController(title: "Loading Error",
                                   message: "There was a problem loading the feed; please check your connection and try again.",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
//        DispatchQueue.main.async {
//            [weak self] in
//            self?.present(ac, animated: true)
//        }

    }

//    func parse(json: Data) {
//        let decoder = JSONDecoder()
//
//        if let jsonPetitions =  try? decoder.decode(Petitions.self, from: json) {
//            petitions = jsonPetitions.results
//            tableView.reloadData()
//        }
//
//    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
//            DispatchQueue.main.async {
//                [weak self] in
//                self?.tableView.reloadData()
//            }
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

