/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation


class ReadyAppsChallengeHandler : ChallengeHandler {
 
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate!

    
    override init() {
        super.init(realm: "SingleStepAuthRealm")
    }
    
    /**
    Callback method for worklight authenticator which determines if the user has been timed out.
    - parameter response:
    */
    override func isCustomResponse(response: WLResponse!) -> Bool {
        if (response != nil && response.getResponseJson() != nil) {
            let jsonResponse = response.getResponseJson() as NSDictionary
            let authRequired = jsonResponse.objectForKey("authRequired") as! Bool?
            if authRequired != nil {
                return authRequired!
            }
        }
        return false
    }
    
    /**
    Callback method for worklight which handles the success scenario
    - parameter response:
    */
    override func onSuccess(response: WLResponse!) {
        submitSuccess(response)
    }
    
    /**
    Callback method for worklight which handles the failure scenario
    - parameter response:
    */
    override func onFailure(response: WLFailResponse!) {
        submitFailure(response)
        
        }
       
    
    /**
    Callback method for worklight which handles challenge presented by the server. This method was most likely called because the user authentication on Worklight has expired. This method will clear the user by calling UserAuthHelper's clearUser method.
    
    - parameter response:
    */
    override func handleChallenge(response: WLResponse!) {
        
        
         UserAuthHelper.clearUser()
        
         let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
         let productDetailViewController = appDelegate.productDetailViewController
        
        if (productDetailViewController.isViewLoaded() == true && productDetailViewController.view.window != nil ) { //check if the view is currently visible
            productDetailViewController.injectWithoutProductAvailability() //only injectWithoutProductAvailability if the productDetailViewController is visible
        }
       
        
        }
    
}

