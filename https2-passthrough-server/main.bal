import ballerina/http;

const string KEYSTORE_PATH = "/Users/user/Documents/GraalVM/netty-servers-shafreen/src/main/resources/security/wso2carbon.jks";
const string TRUSTSTORE_PATH = "/Users/user/Documents/GraalVM/netty-servers-shafreen/src/main/resources/security/client-truststore.jks";
const string password = "wso2carbon";


listener http:Listener serverEP = new(9090, httpVersion = http:HTTP_2_0, secureSocket = {
    key: {
        path: KEYSTORE_PATH,
        password: password
    }
});

service on serverEP {

    resource function 'default [string ...path](http:Request req) returns string|error {
        http:Client clientEP = check new("https://localhost:8080", httpVersion = http:HTTP_2_0, secureSocket = {
            cert: {
                path: TRUSTSTORE_PATH,
                password: password
            }
        });
        string res = check clientEP->forward("/test", req);
        return res;
    }
}
