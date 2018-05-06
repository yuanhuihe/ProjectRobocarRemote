//
//  SockClient.swift
//  ProjectRobocarRemote
//
//  Created by 何元会 on 2018/5/5.
//  Copyright © 2018年 Robocar. All rights reserved.
//

import Foundation
import Starscream

class SocketClient: WebSocketDelegate {
    var socket: WebSocket!
    
    func connect(url:String, port:Int) {
        let link:String = url + ":" + String(port)
        var request = URLRequest(url: URL(string: link)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    // MARK: Websocket Delegate Methods.
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        if let e = error as? WSError {
            print("websocket is disconnected: \(e.message)")
        } else if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
            print("websocket disconnected")
        }
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("Received text: \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Received data: \(data.count)")
    }
    
    func writeData(data:UnsafeRawPointer, len:Int) {
        let data:Data = Data(bytes: data, count: len)
        socket.write(data: data)
    }
    
    func disconnect() {
        socket.disconnect()
    }
}
