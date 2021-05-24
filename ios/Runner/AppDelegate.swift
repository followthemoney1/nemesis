import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
//    let preferences = UserDefaults(suiteName:"group.com.m")
    var notificationPlugin:NotificationPlugin = NotificationPlugin()
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        //MARK: register
        GeneratedPluginRegistrant.register(with: self)
        
//        //MARK: register my notification plugin
        notificationPlugin.register(withRegistrar: self.registrar(forPlugin: "com.sportu.NotificationPlugin"))
        
        //MARK: register delegate notification
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self//notificationService
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        //MARK: check for incoming notification
//        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [String: AnyObject]{
//            self.notificationPlugin.sendData(data:userInfo["id"] as! String)
//        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 * 60) {
        //            self.notificationPlugin.sendData(data: "fkjkfnjerkfnkenfjrnekfjnrelkjwfnwkln")
        //        }
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        completionHandler([
            .alert, .badge, .sound
        ])
        
    }
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                              fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //        print("------ did recive message ------")
        //        let s = self.JSONStringify(value:((userInfo as AnyObject)),prettyPrinted: false)
        completionHandler(.newData)
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let application = UIApplication.shared
        
        let id = response.notification.request.content.userInfo["id"]
        if(application.applicationState == .active){
            self.notificationPlugin.sendData(data:id as! String)
        }
        
        if(application.applicationState == .inactive){
            self.notificationPlugin.sendData(data:id as! String)
        }
        
        completionHandler()
    }
    
    
    func JSONStringify(value: AnyObject,prettyPrinted:Bool = false) -> String{
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        if JSONSerialization.isValidJSONObject(value) {
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                print("error")
                //Access error here
            }
        }
        return ""
        
    }
    
}
