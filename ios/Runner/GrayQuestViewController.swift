//
//  GrayQuestViewController.swift
//  Runner
//
//  Created by Avinash Soni on 04/10/23.
//

import Foundation
import GrayQuestiOSSDK
import UIKit
class GrayQuestViewController: UIViewController, GQPaymentDelegate {
    
    var surveyResult: FlutterResult!
    var configuration: [ String: Any] = [:]
    private lazy var feedbackController: GrayQuestCheckoutVC = {
        
        let auth = [
                    "client_id": "c3acd4e6-ddb8-43c8-a1ba-21e26bfccf5d",
                    "client_secret_key": "b72c3ce537e216c7e6a0876238a915a03ed6665c",
                    "gq_api_key": "6a503d07b3fdfb8cf4a78138fa59e0ce808453d9"
                ]

                let customization = [
                    "logo_url": "https://logo-url.com",
                    "theme_color": "ffd648"
                ]

            configuration = [
                    "auth": auth,
                    "customization": customization,
                    "student_id": "demo_123456",
                    "env": "test",
                    "customer_number": "8425960199"
            ]
        
        let newViewController = GrayQuestCheckoutVC()
        newViewController.config = configuration
//        newViewController.prefill = prefill
        newViewController.delegate = self
//        self.present(newViewController, animated: true, completion: nil)
        
        return newViewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedbackController.present(self, animated: true, completion: nil)
    }

    func gqSuccessResponse(data: [String : Any]?) {
        surveyResult("GQ Success")
        self.navigationController?.popViewController(animated: true)
    }
    
    func gqFailureResponse(data: [String : Any]?) {
        surveyResult("GQ Failed")
        self.navigationController?.popViewController(animated: true)
    }
    
    func gqErrorResponse(error: Bool, message: String) {
        surveyResult("GQError")
        self.navigationController?.popViewController(animated: true)
    }
}

//extension GrayQuestViewController: GQPaymentDelegate {
//
//    func gqSuccessResponse(data: [String : Any]?) {
//        surveyResult("GQ Success")
//    }
//
//    func gqFailureResponse(data: [String : Any]?) {
//        surveyResult("GQ Failed")
//    }
//
//    func gqErrorResponse(error: Bool, message: String) {
//        surveyResult("GQError")
//    }
//}
