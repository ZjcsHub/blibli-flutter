import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    // 屏幕旋转值
    var orientationBlock:((Int) -> ())?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        registerFlutterApplication()
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    override func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        print("屏幕旋转:\(newStatusBarOrientation.rawValue)")
        orientationBlock?(newStatusBarOrientation.rawValue)
    }
    
    
    func registerFlutterApplication() {
        // 1.获取FlutterViewController
        let controller: FlutterViewController = window.rootViewController as! FlutterViewController
        // 2.创建FlutterMethodChannel
        let channel = FlutterMethodChannel(name: "flutter.com/screen", binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler {[weak self] (call:FlutterMethodCall,result: @escaping FlutterResult) in
            //3.1 判断当前方法是否是getBatteryInfo
         
            let callMethod = call.method
            let arguments = call.arguments
            print("callMethod : \(callMethod),arguments :\(String(describing: arguments))")
            if callMethod == "screenRotation" {
                self?.orientationBlock = result
            }
            
        }
        
    }
    
    
}
