import ballerina/http;

listener http:Listener serverEP = new(9090, httpVersion = http:HTTP_2_0);

service on serverEP {

    resource function 'default [string ...path](http:Request req) returns string|error {
        http:Client clientEP = check new("http://localhost:8080", httpVersion = http:HTTP_2_0);
        string res = check clientEP->forward("/test", req);
        return res;
    }
}
