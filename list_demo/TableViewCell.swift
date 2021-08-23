//
//  TableViewCell.swift
//  list_demo
//
//  Created by Mohammed Al-Quraini on 8/22/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    var selectedSegment : Int = 0
    
    var callback: ((_ expand: Bool) -> Void)?
    
    private let segmentedControll : UISegmentedControl = {
        let segmentedControlItems = [
            "Acceptable", "Unacceptable", "N/A"]
        let segmentedControl = UISegmentedControl(items: segmentedControlItems)
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
//        segmentedControl.setWidth(80, forSegmentAt: 0)
//        segmentedControl.setWidth(80, forSegmentAt: 1)
//        segmentedControl.setWidth(80, forSegmentAt: 2)
        
        
        return segmentedControl
    }()
    
    private let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus.bubble")
        imageView.tintColor = .systemOrange
        
        return imageView
    }()
    
    private let textField : UITextField = {
       let tv = UITextField()
        tv.layer.cornerRadius = 8
        tv.layer.borderWidth = 2
        tv.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        tv.backgroundColor = .white
        tv.clipsToBounds = true
        
        return tv
    }()
    
    
    private let cellTextLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(14)
        
        
        return label
    }()
    
    private let aTextLabel : UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = label.font.withSize(15)
        label.isHidden = true
        
        return label
    }()
    

    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

//        addSubview(cellView)
        addSubview(cellTextLabel)
        addSubview(segmentedControll)
        addSubview(textField)
        addSubview(iconImageView)
        addSubview(aTextLabel)
        
        clipsToBounds = true
        
        contentView.isUserInteractionEnabled = false
        
        segmentedControll.addTarget(self, action: #selector(onSegmentChanged(_:)), for: .valueChanged)

        
        
        
//        backgroundColor = .red

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        
        // label
        cellTextLabel.translatesAutoresizingMaskIntoConstraints = false
        cellTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        cellTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
        
        // segmented Controll
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        segmentedControll.topAnchor.constraint(equalTo: cellTextLabel.bottomAnchor, constant: 10).isActive = true
        segmentedControll.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // text field
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        textField.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // icon image view constraint
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: cellTextLabel.centerYAnchor).isActive = true
        
        // label
        aTextLabel.translatesAutoresizingMaskIntoConstraints = false
        aTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        aTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        aTextLabel.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 20).isActive = true
        aTextLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
      

        
        


        
    }
    
    @objc func onSegmentChanged(_ sender : UISegmentedControl){
        

  
//            print(index)
//
            switch sender.selectedSegmentIndex {
            case 0:
                segmentedControll.selectedSegmentTintColor = .systemGreen
                iconImageView.image = UIImage(systemName: "plus.bubble")
                callback!(false)
            
                break

            case 1:
                segmentedControll.selectedSegmentTintColor = .systemRed
                textLabel?.textColor = .white
                iconImageView.image = UIImage(systemName: "xmark")
                callback!(true)
                break

            case 2:
                segmentedControll.selectedSegmentTintColor = .systemGray
                iconImageView.image = UIImage(systemName: "plus.bubble")
                textLabel?.textColor = .white
                callback!(false)
                break

            default:
                segmentedControll.selectedSegmentTintColor = .white
                textLabel?.textColor = .white
                iconImageView.image = UIImage(systemName: "plus.bubble")
                break

            }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        cellTextLabel.text = nil
    }
    
    func configure(_ text : String){
        cellTextLabel.text = text
        
    }
    
    func submitForm(){
        iconImageView.image = UIImage(systemName: "plus.bubble")
        textField.isHidden = true
        aTextLabel.isHidden = false
        aTextLabel.text = textField.text
        
    }
    
    func inEditing(){
        textField.isHidden = false
        aTextLabel.isHidden = true
        
    }
    
    
    
}
