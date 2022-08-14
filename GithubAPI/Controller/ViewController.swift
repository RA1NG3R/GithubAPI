//
//  ViewController.swift
//  GithubAPI
//
//  Created by Subodh Mahajan on 13/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    private var viewModel = OwnerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.rowHeight = 150
        loadOwnerData()
    }
    
    private func loadOwnerData() {
        viewModel.fetchOwnerData { [weak self] in
            self?.tblView.dataSource = self
            DispatchQueue.main.async {
                self?.tblView.reloadData()
            }
            }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let pulls = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(pulls)
        
        return cell
    }
}
