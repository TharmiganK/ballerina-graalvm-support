import ballerina/http;

const string KEYSTORE_PATH = "/Users/user/Documents/GraalVM/netty-servers-shafreen/src/main/resources/security/wso2carbon.jks";
const string password = "wso2carbon";


listener http:Listener serverEP = new(8080, httpVersion = http:HTTP_1_1, secureSocket = {
    key: {
        path: KEYSTORE_PATH,
        password: password
    }
});

service on serverEP {

    resource function 'default [string ...path]() returns string {
        return "HelloWorld";
    }
}
