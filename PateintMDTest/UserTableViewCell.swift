//
//  UserTableViewCell.swift
//  PateintMDTest
//
//  Created by Ahmed on 28/10/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    var userInfo:UserInfo!{
        didSet{
            nameLabel.text=userInfo.name
            titleLabel.text=userInfo.title
            bodyLabel.text=userInfo.body
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class UserInfo{
    var name:String?
    var title:String?
    var body:String?
    init (name:String,title:String,body:String){
        self.name=name
        self.title=title
        self.body=body
    }
}
