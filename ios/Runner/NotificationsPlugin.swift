//
//  NotificationsPlugin.swift
//  Runner
//
//  Created by Dmitry Dyachenko on 10/6/20.
//

import Foundation
import Flutter
import streams_channel

class NotificationPlugin: NSObject {
    
    var handler:StreamHandlerSwift = StreamHandlerSwift()
    public func sendData(data:String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.handler.send(data: data)
        }
    }
    
    func register(withRegistrar registrar: FlutterPluginRegistrar?) {
        let channel =  FlutterStreamsChannel(name: "my_message_handler_ch", binaryMessenger: registrar!.messenger())
        
        channel.setStreamHandlerFactory( { (ar) in
            return self.handler
        })
    }
    
    func register2(withRegistrar registrar: (NSObjectProtocol & FlutterBinaryMessenger)?) {
        
        let channel =  FlutterStreamsChannel(name: "my_message_handler_ch", binaryMessenger: registrar as! FlutterBinaryMessenger);
        
        channel.setStreamHandlerFactory( { (ar) in
            return self.handler
        })
    }
    
    
}

class StreamHandlerSwift: NSObject,FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    
    public func send(data:String){
        if let event = eventSink {
            event(data)
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4 * 60) {
                self.send(data: data)
            }
        }
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        if let arguments = arguments {
            print("StreamHandler - onListen: \(arguments)")
        }
        
        self.eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        if let arguments = arguments {
            print("StreamHandler - onCancel: \(arguments)")
        }
        
        return nil
    }
}
