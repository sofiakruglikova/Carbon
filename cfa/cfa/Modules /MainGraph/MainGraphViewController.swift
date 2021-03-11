//
//  MainGraphViewController.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 10.03.2021.
//

import UIKit

class MainGraphViewController: UIViewController {

    @IBOutlet weak var graphView: MSBBarChartView!
    
    let viewModel = MainGraphViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGraph()
    }
    
    func setUpGraph() {
        self.graphView.setOptions([
            .yAxisTitle("kg of CO2 this month"),
            .yAxisNumberOfInterval(10)
        ])
        self.graphView.assignmentOfColor =  [
            0.0..<0.14: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),
            0.14..<0.28: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),
            0.28..<0.42: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
        self.graphView.setDataEntries(values: [12,24,36])
        self.graphView.setXAxisUnitTitles(["Your current emission",
                                           "Your target emission",
                                           "Global average emission"])
        self.graphView.start()
    }
    
    func showDataView() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dataViewController = storyBoard.instantiateViewController(withIdentifier: "EditDataViewController") as! EditDataViewController
        self.navigationController?.pushViewController(dataViewController, animated: true)
    }
    
    @IBAction func myDataButtonTapped(_ sender: UIButton) {
        
        showDataView()
        
    }
}
