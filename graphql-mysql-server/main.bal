import ballerina/graphql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

string host = "localhost";
int port = 3306;
string user = "root";
string password = "root@123";
string database = "ballerina";

public type Album record {
    string id;
    string title;
    string artist;
    decimal price;
};

service / on new graphql:Listener(9000) {
    private final mysql:Client db;

    function init() returns error? {
        self.db = check new (host, user, password, database, port);
    }

    resource function get album(string id) returns Album|error {
        Album album = check self.db->queryRow(`SELECT * FROM Albums WHERE id = ${id}`);
        return album;
    }
}
