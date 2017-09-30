//
//  SignInViewModel.swift
//  VideoApp
//
//  Created by Subba Nelakudhiti on 9/29/17.
//  Copyright © 2017 Subba Nelakudhiti. All rights reserved.
//

import UIKit
import GoogleSignIn
import GGLSignIn

protocol GoogleLoginDelegats {
    func loginInSuccesc(status:LoginStatus)
    func logoutSuccess()
}

enum LoginStatus:Int
{
    case LOGIN_SUCCESS
    case LOGIN_CANCEL
    case LOGIN_DISMISS
    case OTHER_ERROR    
}
class SignInViewModel: NSObject,GIDSignInUIDelegate,GIDSignInDelegate {
    var delegate:GoogleLoginDelegats?
    var userDetail:GIDGoogleUser!
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    func performGoogleLogin()
    {
         GIDSignIn.sharedInstance().signIn()
    }
    
    //Delegats handling
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
        // activityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        viewController.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
        self.delegate?.loginInSuccesc(status: .LOGIN_DISMISS)
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            userDetail = user
            self.delegate?.loginInSuccesc(status: .LOGIN_SUCCESS)

        } else {
            let nserr = error as NSError
            if nserr.code == -5 {//errorCodeCancelled (-5, for google) {
                // Cancelled task
                self.delegate?.loginInSuccesc(status: .LOGIN_CANCEL)

                
            } else {
                //handle error other than cancelling
                print(nserr)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        //SignOut
        if error != nil {
            //handle error
            print(error)
        }
    }
    
}
