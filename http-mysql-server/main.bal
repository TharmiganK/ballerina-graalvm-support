import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

string host = "localhost";
int port = 3306;
string user = "root";
string password = "root@123";
string database = "ballerina";

public type Album record {|
    string id;
    string title;
    string artist;
    decimal price;
|};

service / on new http:Listener(8080) {
    private final mysql:Client db;

    function init() returns error? {
        self.db = check new (host, user, password, database, port);
    }

    resource function get albums() returns Album[]|error? {
        stream<Album, sql:Error?> albumStream = self.db->query(`SELECT * FROM Albums`);
        Album[]? albums = check from Album album in albumStream select album;
        check albumStream.close();
        return albums;
    }

    resource function get albums/[string id]() returns Album|http:NotFound|error {
        Album|sql:Error result = self.db->queryRow(`SELECT * FROM Albums WHERE id = ${id}`);
        if result is sql:NoRowsError {
            return <http:NotFound>{};
        } else {
            return result;
        }
    }

    resource function post album(@http:Payload Album album) returns Album|error {
        _ = check self.db->execute(`
            INSERT INTO Albums (id, title, artist, price)
            VALUES (${album.id}, ${album.title}, ${album.artist}, ${album.price});`);
        return album;
    }
}