import ballerina/http;

listener http:Listener serverEP = new(8080, httpVersion = http:HTTP_2_0);

service on serverEP {

    resource function 'default [string ...path]() returns string {
        return "HelloWorld";
    }
}
