import ballerina/io;
import ballerina/http;

configurable string port = ?;

public function main() returns error? {
    http:Client clientEP = check new("http://localhost:" + port, httpVersion = http:HTTP_1_1);
    http:Response res = check clientEP->get("/test");
    io:println(check res.getTextPayload());
}