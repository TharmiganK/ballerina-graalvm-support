import ballerina/http;

listener http:Listener securedEP = new(8080, httpVersion = http:HTTP_2_0,
    secureSocket = {
        key: {
            certFile: "certsandkeys/public.crt",
            keyFile: "certsandkeys/private.key"
        }
    }
);

@http:ServiceConfig {
    auth: [
        {
            jwtValidatorConfig: {
                issuer: "wso2",
                audience: "ballerina",
                signatureConfig: {
                    certFile: "certsandkeys/public.crt"
                },
                scopeKey: "scp"
            },
            scopes: ["admin"]
        }
    ]
}
service on securedEP {

    resource function 'default [string ...path]() returns string {
        return "Hello, World!";
    }
}
