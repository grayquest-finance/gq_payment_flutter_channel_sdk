import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var navigationController: UINavigationController!
    var surveyResult: FlutterResult!
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
      let controller = self.window.rootViewController as! FlutterViewController
              linkNativeCode(controller: controller)
      GeneratedPluginRegistrant.register(with: self)
      
      self.navigationController = UINavigationController(rootViewController: controller)
      self.window.rootViewController = self.navigationController
      self.navigationController.setNavigationBarHidden(true, animated: false)
      self.window.makeKeyAndVisible()
              
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
}

extension AppDelegate {
    
    func linkNativeCode(controller: FlutterViewController) {
        setupMethodChannelForSurveyMonkey(controller: controller)
    }
    
    private func setupMethodChannelForSurveyMonkey(controller: FlutterViewController) {
        
        let surveyMonkeyChannel = FlutterMethodChannel.init(name: "GQPaymentSDK/channel", binaryMessenger: controller as! FlutterBinaryMessenger)
        
        surveyMonkeyChannel.setMethodCallHandler { (call, result) in
            
            
            self.surveyResult = result
            
            if call.method == "initiateGQPayment"{
                
                self.surveyResult("SDk Open Success")
                
                let vc = UIStoryboard.init(name: "Main", bundle: .main)
                                        .instantiateViewController(withIdentifier: "GrayQuestViewController") as! GrayQuestViewController
                vc.surveyResult = result
                self.navigationController.pushViewController(vc, animated: true)
            }
        }
    }
}
