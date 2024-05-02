//
//  ViewController.swift
//  CodeController
//
//  Created by Anthony TK on 9/12/23.
//
// tab baar, table view controlller

//Settings from MainStoryboard:
// - In TableViewController,
// - in "Cell",
//   subtitle = subtitle
//   accessory type = disclosure indicator

// Hierarchy of controllers:
// build embed in > navigation controller from base viewCOntroller, then embed in> tab bar controller
// this builds in sequence (1) tab bar con > (2) nav con > (3) view con

// we'll design one in storyboard, then dupes in the code
// tab bar uses an array to manage panels

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()


        // button assignment
        // why do buttons need to be rendered before the navigation controller crap?
        let aboutButton = UIBarButtonItem(title: "About", style: .plain,
                                          target: self, action: #selector(aboutAlert))

        let filterButton = UIBarButtonItem(title: "Filter", style: .plain,
                                          target: self, action: #selector(showFilter))

        
        navigationItem.rightBarButtonItems = [aboutButton, filterButton]
        
        // define what to load
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)        // we're ok to parse - now call parse
                return
            }
        }
        
        showError()

    }

    @objc func aboutAlert() {
        let msg = "blah"
        let ac = UIAlertController(title: "About", message: msg, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    
    // build show error alert
    func showError() {
        let msg = "Prob with loading feed. Check conn"
        let ac = UIAlertController(title: "Loading error", message: msg, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    // define rows in table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    // define format of each panel in table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body

        return cell
    }
    
    // render DVC when you click row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // parse for json
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    // apply filters
    @objc func showFilter() {
        let msg = "Input your filter here."
        let ac = UIAlertController(title: "Apply filter:", message: msg, preferredStyle: .actionSheet)
        
        
    
        ac.addTextField()
        
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            // do something interesting with "answer" here

        }

        
//        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: applyFilter))

        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func applyFilter(action: UIAlertAction) {
        let text = action
        print("filter applied: \(text)")
    }
    
}

