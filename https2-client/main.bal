import ballerina/io;
import ballerina/http;

configurable string port = ?;

const string TRUSTSTORE_PATH = "/Users/user/Documents/GraalVM/netty-servers-shafreen/src/main/resources/security/client-truststore.jks";
const string password = "wso2carbon";

public function main() returns error? {
    http:Client clientEP = check new("https://localhost:" + port, secureSocket = {
        cert: {
            path: TRUSTSTORE_PATH,
            password: password
        }
    }, httpVersion = http:HTTP_2_0);
    http:Response res = check clientEP->get("/test");
    io:println(check res.getTextPayload());
}
