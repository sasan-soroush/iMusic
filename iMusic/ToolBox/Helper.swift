//
//  Helper.swift
//  iMusic
//
//  Created by New User on 12/29/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class Helper  {
    
    static let shared = Helper()
    
    func getMiddleYAxisPoint(up_y : CGFloat , down_y : CGFloat , height : CGFloat) -> CGFloat {
        let distance = down_y - up_y
        let middlePoint = up_y + distance/2
        let heightOfAmountTF = height
        let startingPointInYAxis = middlePoint - heightOfAmountTF/2
        return startingPointInYAxis
    }
    
    func getFontsList() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("--------------------------------------\n--------------------------------------")
            print("Family: \(family) Font names: \(names)")
            print("--------------------------------------\n--------------------------------------")
        }
    }
    
    func handleError(response : DataResponse<Any> ) {
        
        let generalErrorMessage = "Something went wrong! Please check try again later !"
        guard let presenter = UIApplication.topViewController() else {return}
        if let data = response.data {
            do {
                let responseJSON = try JSON(data: data)
                let message: String = responseJSON["clientMsg"].stringValue
                if !message.isEmpty {
                        alert(presenter, title: "", body: message)
                } else {
                        alert(presenter, title: "" , body: generalErrorMessage)
                }
            } catch {
                    alert(presenter, title: "", body: generalErrorMessage)
            }
        }
        else {
                alert(presenter, title: "", body: generalErrorMessage)
        }
        switch response.response?.statusCode {
        case 401:
            break
        //TODO:- Force logout
        default:
            break
        }
    }
    
    func alert(_ controller:UIViewController, title:String, body:String){
        
        let alertController = UIAlertController(title: title, message:body, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        controller.present(alertController, animated: true, completion: nil)
        
        //        controller.view.hideToastActivity()
    }
}
