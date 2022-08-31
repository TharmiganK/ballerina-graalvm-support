import ballerina/io;
import ballerina/websocket;

service /echo on new websocket:Listener(9090) {
   resource function get .() returns websocket:Service|websocket:Error {
       return new WsService();
   }
}

service class WsService {
    *websocket:Service;
    
    remote function onMessage(websocket:Caller caller, string text) returns websocket:Error? {
        io:println("\ntext message: " + text);
        return caller->writeMessage("You said: " + text);
    }
}
