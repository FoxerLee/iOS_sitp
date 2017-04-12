//
//  ConfirmTableViewController.swift
//  tiankeng
//
//  Created by 李源 on 2017/4/3.
//  Copyright © 2017年 foxerlee. All rights reserved.
//

import UIKit
//import LeanCloud
import AVOSCloud
import os.log

class ConfirmTableViewController: UITableViewController {

    @IBOutlet weak var confirmButton: UIBarButtonItem!
    var message: Message!
    override func viewDidLoad() {
        super.viewDidLoad()

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //货物详情的cell
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PackageConfirmTableViewCell", for: indexPath) as! PackageConfirmTableViewCell
            cell.packageLabel.text = message?.package
            cell.describeLabel.text = message?.describe
            cell.timeLabel.text = message?.time
            cell.photoImageView.image = message?.photo
            
            return cell
        }
        //寄货人的cell
        else if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FounderConfirmTableViewCell", for: indexPath) as! FounderConfirmTableViewCell
            let query = AVQuery(className: "_User")
            query.whereKey("mobilePhoneNumber", equalTo: message.founderPhone)
            
            var object = query.findObjects()
            let founder = object?.popLast() as! AVObject
            
            
            cell.founderNameLabel.text = founder.object(forKey: "username") as? String
            cell.founderPhoneLabel.text = founder.object(forKey: "mobilePhoneNumber") as? String
            cell.founderAddressLabel.text = founder.object(forKey: "address") as? String
                        
            return cell
        }
            
        //收货人的cell
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverConfirmTableViewCell", for: indexPath) as! ReceiverConfirmTableViewCell
            
            cell.ReceiverNameLabel.text = message?.name
            cell.ReceiverPhoneLabel.text = message?.phone
            cell.ReceiverAddressLabel.text = message?.address
            
            return cell
        }
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "货物信息"
        }
            
        else if (section == 1) {
            return "寄货人信息"
        }
            
        else {
            return "收货人信息"
        }
    }



}
