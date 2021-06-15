const mysql = require('mysql')
const cors = require('cors');

const express = require('express'),
  app = express(),
  bodyParser = require('body-parser');

//const port = process.env.PORT || 8765;

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'mysqlpassword',  //Your Password HERE!
    database: 'ntuadb'
});

db.connect(err => {
    if (err) throw err;
    else console.log("Database connected successfully")
})

app.use(cors())
app.use(bodyParser.json())

var routes = require('./app/routes/appRoutes.js'); //importing route
routes(app); //register the route

app.listen(8765, () => {
    console.log("Server listening on port 8765.")
})

module.exports = {
    app,
    db
}