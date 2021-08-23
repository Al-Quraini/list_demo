//
//  ViewController.swift
//  list_demo
//
//  Created by Mohammed Al-Quraini on 8/22/21.
//

import UIKit


class ViewController: UIViewController {
    
    private let tableView = UITableView()
    
    
    private var submitting = false
    
    private let descriptionView : UIView = {
       let uiView = UIView()
        uiView.backgroundColor = .gray
        uiView.bounds = uiView.frame.inset(by: UIEdgeInsets(top: 10, left: -5, bottom: 10, right: -20))
        let label = UILabel()
        label.text = "Areas of observation - please note concern(s) if any, as well as corrective actions(s)"
        label.textColor = .white
        label.numberOfLines = 0
        
        
        uiView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: uiView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: uiView.trailingAnchor).isActive = true
        
        return uiView
    }()
    
    private let submitBtn : UIButton = {
       let btn = UIButton()
        btn.setTitle("Submit", for: .normal)
        btn.setTitleColor(.systemOrange, for: .normal)
        btn.backgroundColor = .systemGray6
        btn.layer.borderWidth = 1
        btn.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        return btn
    }()
    
    private let texts : [String] = [
    "Surrounding Areas / Adjacent Activities", "Building Grounds", "Building Structure", "Water System", "other"]
    
    private var expanded : [Bool] = [
    false , false , false, false , false ]
    
    private var selectedSegments : [Bool] = [
    false , false , false, false , false ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Cooler Facility Risk Assessment"
        
        // subviews
        view.addSubview(descriptionView)
        view.addSubview(tableView)
        view.addSubview(submitBtn)
        
        // delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // table view configuration
        tableViewConfiguration()
        
        // target
        submitBtn.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // description view constraints
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        
        // submit button
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        submitBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        submitBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        submitBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        submitBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true

        // tableview constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: submitBtn.topAnchor).isActive = true
        
        

        

    }
    
    // table view configuration
    func tableViewConfiguration(){
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.rowHeight = 100
        
        
    }
    @objc private func submitForm(){
        submitting = true
        tableView.reloadData()
    }
    
    func checkForSubmission(){
        for checked in selectedSegments {
            if !checked {
                return
            }
        }
        
        descriptionView.backgroundColor = .systemGreen
    }

}

//MARK: - UITableViewDelegate , UITableViewDataSource
extension ViewController : UITableViewDelegate , UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expanded[indexPath.row] {
           return 150
        }

        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .systemGray4
        }
        
        if submitting {
            cell.submitForm()
        } else {
            cell.inEditing()
        }
        
        
        cell.callback = { (expand) -> Void in
            
            self.submitting = false
            
            self.expanded[indexPath.row] = expand
            self.selectedSegments[indexPath.row] = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                self.tableView.reloadRows(at: [indexPath.self], with: .automatic)
                self.tableView.reloadData()
            
            })
            
            self.checkForSubmission()
            
                }
        
        
            cell.configure(texts[indexPath.row])
            return cell

        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

