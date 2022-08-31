import ballerina/grpc;
import ballerina/log;

AlbumsClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    Album album = check ep->getAlbum("1");
    log:printInfo("Response to get album : " + album.toJsonString());

    album = check ep->addAlbum({id: "4", title: "Test Title", artist: "Test Artist", price: 67.86});
    log:printInfo("Response to add album : " + album.toJsonString());

    stream<Album, grpc:Error?> albums = check ep->listAlbums();
    check albums.forEach(function(Album album_) {
        log:printInfo("Response to list albums : " + album_.toJsonString());
    });
}
