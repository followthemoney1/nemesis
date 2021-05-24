//
//  NotificationService.swift
//  NotificationService
//
//  Created by Dmitry Dyachenko on 10/6/20.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
//            let t = bestAttemptContent.userInfo["title"]
//            let b = bestAttemptContent.userInfo["body"]
//            if let title = t {
//                bestAttemptContent.title = title as! String;
//            }
//            if let body = b{
//                bestAttemptContent.body = body as! String;
//            }


//            let date = Date()
//            let calendar = Calendar.current
//            let hour = calendar.component(.hour, from: date)
//            let minutes = calendar.component(.minute, from: date)
//            print("fwefwefwefwefwfwwk-------------------")
//            print(minutes)
          
               
                contentHandler(bestAttemptContent)
           
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
       print("serviceExtensionTimeWillExpire")
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
//            let date = Date()
//            let calendar = Calendar.current
//            let hour = calendar.component(.hour, from: date)
//            let minutes = calendar.component(.minute, from: date)
//            print("fwefwefwefwefwfwwk-------------------")
//            print(minutes)
//            if(minutes>14){
              contentHandler(bestAttemptContent)
//            }
        }
    }

}
