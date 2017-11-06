//
//  ViewController.swift
//  PateintMDTest
//
//  Created by Ahmed on 28/10/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var userInfo=[NameInfo]()
    var titleInfo=[TitleInfo]()
    var bodyInfo=[BodyInfo]()
    let dispatch_group=DispatchGroup()
    var userReport=[UserInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
       initialSetUp()
    }
    func initialSetUp(){
        tableView.dataSource=self
        tableView.delegate=self
        tableView.estimatedRowHeight=tableView.rowHeight
        tableView.rowHeight=UITableViewAutomaticDimension
        dispatch_group.enter()
        getUserNameInfo(url:"users")
        dispatch_group.enter()
        getUserNameInfo(url: "albums")
        dispatch_group.enter()
        self.getUserNameInfo(url: "posts")
        dispatch_group.notify(queue: .main) {
            for item in self.userInfo{
            let titleArray=self.titleInfo.filter { $0.userId==item.id}
            var title=""
            for item in titleArray{
                title += item.title!
                title += ","
            }
            let bodyInfo=self.bodyInfo.filter { $0.userId==item.id}
            var body=""
            for item in bodyInfo{
                body += item.body!
                body+=","
            }
            self.userReport.append(UserInfo(name:item.name!, title: title, body: body))
            }
            self.tableView.reloadData()
 
        }
    }
    
    func getUserNameInfo(url:String){
        let urlString="https://jsonplaceholder.typicode.com/"+url
        let request=URLRequest(url: URL(string: urlString)!)
        let task=URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                return
            }
            if let useableData=data{
                do {
                    if let jsonData=try JSONSerialization.jsonObject(with: useableData, options: .mutableContainers)as?NSArray{
                        switch url{
                            case "users":
                            self.userInfo=NameInfo.modelsFromDictionaryArray(array: jsonData)
                            case "albums":self.titleInfo=TitleInfo.modelsFromDictionaryArray(array: jsonData)
                            case "posts":self.bodyInfo=BodyInfo.modelsFromDictionaryArray(array: jsonData)
                        default:
                            break
                        }
                      self.dispatch_group.leave()
                    }
                }catch{
                    
                }
            }
        }
        task.resume()
    }
    
    


}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userReport.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as!UserTableViewCell
            cell.userInfo=self.userReport[indexPath.row]
        return cell
    }
}

