// CouchDB for metadata
// Git blobs for file contents
// Access through HTTP

// Not in a runnable state! Just some pasted code.

// Git:
var gitteh = require("gitteh"), 
      path = require("path"),
        fs = require("fs");

var repository = gitteh.openRepository(path.join(__dirname, "..", ".git"));
var blob = repository.getBlob(sha1);

// HTTP:
var http = require('http');
http.createServer(function (req, res) {
      res.writeHead(200, {'Content-Type': 'text/plain'});
        res.end('Hello World\n');
}).listen(1337, "127.0.0.1");
console.log('Server running at http://127.0.0.1:1337/');

// CouchDB:
var couchdb = require("couchdb-api");

// connect to a couchdb server (defaults to localhost:5984)
var server = couchdb.srv();

// test it out!
server.info(function (err, response) {
    console.log(response);
  
    // should get `{ couchdb: "Welcome", version: "1.0.1" }
    // if something went wrong, the `err` argument would provide the error that CouchDB provides
});

// select a database
var db = server.db("my-database");

db.info(function (err, response) {
    console.log(response);

    // should see the basic statistics for your test database
    // if you chose a non-existant db, you'd get { error: "not_found", reason: "no_db_file" } in place of `err`
});
