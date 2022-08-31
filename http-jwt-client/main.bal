import ballerina/io;
import ballerina/http;

configurable string port = ?;

public function main() returns error? {
    http:Client clientEP = check new("https://localhost:" + port,
        auth = {
            username: "ballerina",
            issuer: "wso2",
            audience: ["ballerina", "ballerina.org", "ballerina.io"],
            keyId: "5a0b754-895f-4279-8843-b745e11a57e9",
            jwtId: "JlbmMiOiJBMTI4Q0JDLUhTMjU2In",
            customClaims: { "scp": "admin" },
            expTime: 3600,
            signatureConfig: {
                config: {
                    keyFile: "certsandkeys/private.key"
                }
            }
        },
        secureSocket = {
            cert: "certsandkeys/public.crt"
        },
        httpVersion = http:HTTP_2_0
    );
    http:Response res = check clientEP->get("/test");
    io:println(check res.getTextPayload());
}