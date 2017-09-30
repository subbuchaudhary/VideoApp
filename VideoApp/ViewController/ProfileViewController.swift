//
//  ProfileViewController.swift
//  VideoApp
//
//  Created by Subba Nelakudhiti on 9/29/17.
//  Copyright © 2017 Subba Nelakudhiti. All rights reserved.
//

import UIKit
import GoogleSignIn
class ProfileViewController: UITableViewController {

    let heading = ["Name","Email"]
    var userProfile:GIDGoogleUser!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        
    }

    @IBAction func logout()
    {
        GIDSignIn.sharedInstance().signOut()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : UINavigationController = storyboard.instantiateViewController(withIdentifier: "signInController") as! UINavigationController
        
        let controller:SignInViewController = vc.topViewController as! SignInViewController
        
        appDelegate.window!.rootViewController = vc

        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heading.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as UITableViewCell
        
         cell.textLabel?.text = heading[indexPath.row]
        switch indexPath.row {
        case 0:
           cell.detailTextLabel?.text = userProfile.profile.name
        default:
            cell.detailTextLabel?.text = userProfile.profile.email
        }
        return cell
    }
    

   
}
