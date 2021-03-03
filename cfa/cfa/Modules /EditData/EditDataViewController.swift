//
//  EditDataViewController.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 01.03.2021.
//

import UIKit

class EditDataViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = EditDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSetUp()

    }
    
    func tableSetUp() {
        
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.makeDummyData {
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func buttonAddTapped(_ sender: UIButton) {
        
        viewModel.calculation()
        
    }
}

extension EditDataViewController: UITableViewDelegate {
    
}

extension EditDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let carbon = viewModel.data[indexPath.row]
        cell.textLabel?.text = carbon.title
        cell.detailTextLabel?.text = carbon.subtitle
        print(carbon.subtitle)
        //cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        //cell.textLabel?.textColor = .black
        return cell
    }
    
    
}
