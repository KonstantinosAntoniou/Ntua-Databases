const db = require('../server.js')

function insertService (req, res) {
    const newService = "INSERT INTO Services (service_description)"
        + "VALUES ("
        + `'${req.body.service_description}');`
    
    db.query(newService, async (err, rows) => {
        if(err) res.status(400).send(err.message) 
        else {
            const register = req.body.must_register
            let service_ID = rows.service_ID

            if(register) db.query(`INSERT INTO Services_that_need_registration VALUES (${service_ID});`)
            else db.query(`INSERT INTO Services_that_dont_need_registration VALUES (${service_ID});`)
            
            res.send({"service_ID": service_ID})
        }
    })
}
exports.insertService = insertService


function updateService (req, res) {
    const service_ID = req.params.service_ID
    const service_description = (req.body.service_description) ? `service_description='${req.body.service_description}',` : ""
    
    const update_Service = `UPDATE Services SET ${service_description} WHERE service_ID=${service_ID};`
    
    const deleteRegSer = `DELETE FROM Services_that_need_registration WHERE service_ID=${service_ID};`
    const deleteUnRegSer = `DELETE FROM Services_that_dont_need_registration WHERE service_ID=${service_ID};`

    db.query(update_Service, (err, rows) => {
        if(err) res.status(400).send(err.message) 
        else {
            const register = req.body.must_register
            if(register) {
                db.query(deleteRegSer, async (err2, rows) => {
                    if(err2) res.status(400).send(err2.message) 
                    else db.query(`INSERT INTO Services_that_need_registration VALUES (${service_ID});`)
                })
            }
            else {
                db.query(deleteUnRegSer, async (err3, rows) => {
                    if(err3) res.status(400).send(err3.message) 
                    else db.query(`INSERT INTO Services_that_dont_need_registration VALUES (${service_ID});`)
                })
            }
            res.send({"NFC_ID": NFC_ID})
        }
    })
}
exports.updateService = updateService


function deleteService (req, res) {
    delete_Service = `DELETE FROM Services WHERE service_ID=${req.params.service_ID};`
    db.query(delete_Service, (err, rows) => {
        if(err) res.status(400).send(err.message) 
        else {
            db.query(`DELETE FROM Services_that_need_registration WHERE service_ID=${req.params.service_ID};`)
            db.query(`DELETE FROM Services_that_dont_need_registration WHERE service_ID=${req.params.service_ID};`)
            res.send()
        }
    })
}
exports.deleteService = deleteService