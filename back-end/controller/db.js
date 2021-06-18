'user strict';

var mysql = require('mysql');

//local mysql db connection

var connection = mysql.createConnection({
	host     : 'localhost',
	user     : 'root',
	password : '123456q!',
	database : 'ntuadb'
});

connection.connect(function(err) {
    	if (err) throw err;
      console.log("Connected!");
});

module.exports = connection;
