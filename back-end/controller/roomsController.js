//const db = require('../server.js');
const sql = require('./db.js');

function insertRoom (req, res) {
    const newRoom = "INSERT INTO Hotel_rooms (number_of_beds, name_of_the_room, description_of_position)"
        + "VALUES ("
        + `${req.body.number_of_beds},`
        + `'${req.body.name_of_the_room}',`
        + `'${req.body.description_of_position}');`
    
    db.query(newRoom, async (err, rows) => {
        if(err) res.status(400).send(err.message) 
        else res.send({"hotel_room_ID": rows.hotel_room_ID})
    })
}
exports.insertRoom = insertRoom


function updateRoom (req, res) {
    const hotel_room_ID = req.params.hotel_room_ID
    const number_of_beds = (req.body.number_of_beds) ? `number_of_beds=${req.body.number_of_beds},` : ""
    const name_of_the_room = (req.body.name_of_the_room) ? `name_of_the_room='${req.body.name_of_the_room}',` : ""
    const description_of_position = (req.body.description_of_position) ? `description_of_position='${req.body.description_of_position}',` : ""
    
    const update_Room = `UPDATE Hotel_rooms SET ${number_of_beds} ${name_of_the_room} ${description_of_position} WHERE hotel_room_ID=${hotel_room_ID};`

    db.query(update_Room, (err, rows) => {
        if(err) res.status(400).send(err.message) 
        else res.send({"message": rows.message})
    })
}
exports.updateRoom = updateRoom


function deleteRoom (req, res) {
    delete_Room = `DELETE FROM Hotel_rooms WHERE hotel_room_ID=${req.params.hotel_room_ID};`
    db.query(delete_Room, (err, rows) => {
        if(err) res.status(400).send(err.message) 
        else res.send()
    })
}
exports.deleteRoom = deleteRoom



function getRoom (req, res) {
    get_Room = `SELECT * FROM Hotel_rooms WHERE hotel_room_ID=${req.params.hotel_room_ID};`
    sql.query(get_Room, (err, rows) => {
        if(err) res.status(400).send(err.message) 
        else res.send(rows)
    })
}
exports.getRoom = getRoom;

/*
exports.getRoom2 = function(req,res){
    get_Room2 = `SELECT * FROM Hotel_rooms WHERE hotel_room_ID=${req.params.hotel_room_ID};`
    sql.query(get_Room2, function(err2,res2){
        if(err2) res.status(400).send(err2.message)
        else res.send(res2)
    })
}
*/