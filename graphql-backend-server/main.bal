import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    resource function get greeting() returns string {
        return "Hello, World";
    }
}
