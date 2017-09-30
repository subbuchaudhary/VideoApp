//
//  SignInViewController.swift
//  VideoApp
//
//  Created by Subba Nelakudhiti on 9/29/17.
//  Copyright © 2017 Subba Nelakudhiti. All rights reserved.
//

import UIKit
import GoogleSignIn
import GGLSignIn
class SignInViewController: UIViewController {
    @IBOutlet weak var btnSignIn:UIButton!
    var signInModelView = SignInViewModel()
    var loder  = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
    }
    
    //MARK : Custom SignIn Button action
    @IBAction func signInAction(sender:UIButton)
    {
        loder = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        // Position Activity Indicator in the center of the main view
        loder.center = view.center
        loder.hidesWhenStopped = false
        loder.startAnimating()
        view.addSubview(loder)
        UIApplication.shared.beginIgnoringInteractionEvents()
        signInModelView.delegate = self
        signInModelView.performGoogleLogin()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let string =  segue.identifier
        if string == "videTabbarController"
        {
            let tabbarController = segue.destination
            
            if let vc: HomeViewController = tabbarController.childViewControllers[0] as? HomeViewController {
                vc.userDetail = signInModelView
            }
            
            if let profileVc: ProfileViewController = tabbarController.childViewControllers[1] as? ProfileViewController {
                profileVc.userProfile = signInModelView.userDetail
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SignInViewController:GoogleLoginDelegats
{
    func loginInSuccesc(status: LoginStatus) {
        loder.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()

        switch status {
        case .LOGIN_SUCCESS:
            print("Login success")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : UITabBarController = storyboard.instantiateViewController(withIdentifier: "videTabbarController") as! UITabBarController
            
            if let homeVc: UINavigationController = vc.childViewControllers[0] as? UINavigationController {
                
                let controller:HomeViewController = homeVc.topViewController as! HomeViewController
                controller.userDetail = signInModelView
            }
            if let profileVc: UINavigationController = vc.childViewControllers[1] as? UINavigationController {
                let profielCotroller  = profileVc.topViewController as! ProfileViewController
                profielCotroller.userProfile = signInModelView.userDetail
            }
            appDelegate.window!.rootViewController = vc

        
            /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            // Create the tabBarController using Storyboard ID
            self.tabBarController = (MC_MainTabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"mainView"];
            // Show the Tab Bar Controller
            [self.window setRootViewController:self.tabBarController];*/
            
            
            //self.performSegue(withIdentifier: "videTabbarController", sender: nil)

        
           /* let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : UITabBarController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! UITabBarController
            //vc.userDetail = signInModelView
            self.tabBarController?.pushViewController(vc, animated: true)*/
        case .LOGIN_DISMISS:
            print("Login dismiss")
        case .LOGIN_CANCEL:
            print("Login cancel")
        default:
            print("Other error")
        }
    }
    
    func logoutSuccess() {
        loder.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
        GIDSignIn.sharedInstance().signOut()
    }
}
