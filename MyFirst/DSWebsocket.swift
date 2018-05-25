import UIKit
import Starscream
@objc public protocol DSWebSocketDelegate: NSObjectProtocol{
    /**websocket 连接成功*/
    optional func websocketDidConnect(sock: DSWebSocket)
    /**websocket 连接失败*/
    optional  func websocketDidDisconnect(socket: DSWebSocket, error: NSError?)
    /**websocket 接受文字信息*/
    func websocketDidReceiveMessage(socket: DSWebSocket, text: String)
    // **websocket 接受二进制信息*/
    optional  func  websocketDidReceiveData(socket: DSWebSocket, data: NSData)
}
public class DSWebSocket: NSObject,WebSocketDelegate {
    var socket:WebSocket!
    weak var webSocketDelegate: DSWebSocketDelegate?
    //单例
    class func sharedInstance() -> DSWebSocket
    {
        return manger
    }
    static let manger: DSWebSocket = {
        return DSWebSocket()
    }()
    //MARK:- 链接服务器
    func connectSever(){
        socket = WebSocket(url: NSURL(string: "ws://192.168.0.101:8080/shop"))
            socket.delegate = self
            socket.connect()
    }
    //发送文字消息
    func sendBrandStr(brandID:String){
        socket.writeString(brandID)
    }
    //MARK:- 关闭消息
    func disconnect(){
        socket.disconnect()
    }
    //MARK: - WebSocketDelegate
    public func websocketDidConnect(socket: WebSocket){
        debugPrint("连接成功了: \(error?.localizedDescription)")
        webSocketDelegate?.websocketDidConnect!(self)
    }
    public func websocketDidDisconnect(socket: WebSocket, error: NSError?){
        debugPrint("连接失败了: \(error?.localizedDescription)")
        webSocketDelegate?.websocketDidDisconnect!(self, error: error)
    }
    //注：一般返回的都是字符串
    public func websocketDidReceiveMessage(socket: WebSocket, text: String){
        debugPrint("接受到消息了: \(error?.localizedDescription)")
        webSocketDelegate?.websocketDidReceiveMessage!(self, text: text)
    }
    public func websocketDidReceiveData(socket: WebSocket, data: NSData){
        debugPrint("data数据")
        webSocketDelegate?.websocketDidReceiveData!(self, data: data)
    }
}
