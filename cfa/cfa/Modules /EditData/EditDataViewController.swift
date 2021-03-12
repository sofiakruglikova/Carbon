//
//  EditDataViewController.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 01.03.2021.
//

import UIKit

protocol EditDataDelegate {
    
    func addData(carbon: EditData.Carbon)
    
    func updateTable()
    
    func updateData(carbonPair: (Int, EditData.Carbon))
}

class EditDataViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = EditDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSetUp()

    }
    
    func tableSetUp() {
        
        viewModel.dm.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        /*viewModel.makeDummyData {
            self.tableView.reloadData()
        }*/
        
    }
    
    func showAddDataModel(carbonPair: (Int, EditData.Carbon)? = nil) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let modalViewController = storyBoard.instantiateViewController(withIdentifier: "AddDataViewController") as! AddDataViewController
        modalViewController.modalPresentationStyle = .formSheet
        modalViewController.delegate = self
        modalViewController.currentCarbonPair = carbonPair
        present(modalViewController, animated: true, completion: nil)
        }
    
    @IBAction func buttonAddTapped(_ sender: UIButton) {
        
//        viewModel.calculation()
        showAddDataModel()
        
    }
}

extension EditDataViewController: UITableViewDelegate {
    
}

extension EditDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dm.carbonData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let carbon = viewModel.dm.carbonData[indexPath.row]
        cell.textLabel?.text = carbon.title
        cell.detailTextLabel?.text = carbon.subtitle
        print(carbon.subtitle)
        //cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        //cell.textLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAddDataModel(carbonPair: (indexPath.row, viewModel.dm.carbonData[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteData(at: indexPath)
            //tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            print("Insert")
        }
    }
}

extension EditDataViewController: EditDataDelegate {
    
    func updateTable() {
        tableView.reloadData()
    }
    
    func addData(carbon: EditData.Carbon) {
        viewModel.addData(carbon: carbon)
    }
    
    func updateData(carbonPair: (Int, EditData.Carbon)) {
        viewModel.updateData(carbonPair: carbonPair)
    }
}

extension EditDataViewController: UpdateDataDelegate {
    
    func update() {
        tableView.reloadData()
    }
    
}
