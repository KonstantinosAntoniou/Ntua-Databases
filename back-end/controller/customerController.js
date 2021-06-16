const db = require('../server.js')

function insertCustomer (req, res) {
    const phones = req.body.phone
    const emails = req.body.email
    const newCustomer = "INSERT INTO Customer (firstname, lastname, dateofbirth, number_of_indentification_document, type_of_indentification_document, issuing_authority)"
        + "VALUES ("
        + `'${req.body.firstname}',`
        + `'${req.body.lastname}',`
        + `'${req.body.dateofbirth}',`
        + `'${req.body.number_of_indentification_document}',`
        + `'${req.body.type_of_indentification_document}',`
        + `'${req.body.issuing_authority}');`
    
    db.query(newCustomer, async (err, rows) => {
        if(err) res.status(400).send(err.message) 
        else {
            let NFC_ID = rows.NFC_ID
            await phones.forEach(phone => {
                db.query(`INSERT INTO Customer_phones VALUES (${NFC_ID},'${phone}');`)
            })
            await emails.forEach(email => {
                db.query(`INSERT INTO Customer_emails VALUES (${NFC_ID},'${email}');`)
            })
            res.send({"NFC_ID": NFC_ID})
        }
    })
}
exports.insertCustomer = insertCustomer


function updateCustomer (req, res) {
    const NFC_ID = req.params.NFC_ID
    const phones = (req.body.phone)
    const emails = req.body.email
    const firstname = (req.body.firstname) ? `firstname='${req.body.firstname}',` : ""
    const lastname = (req.body.lastname) ? `lastname='${req.body.lastname}',` : ""
    const dateofbirth = (req.body.dateofbirth) ? `dateofbirth='${req.body.dateofbirth}',` : ""
    const number_of_indentification_document = (req.body.number_of_indentification_document) ? `number_of_indentification_document='${req.body.number_of_indentification_document}',` : ""
    const type_of_indentification_document = (req.body.type_of_indentification_document) ? `type_of_indentification_document='${req.body.type_of_indentification_document}'` : ""
    const issuing_authority = (req.body.issuing_authority) ? `issuing_authority='${req.body.issuing_authority}'` : ""

    const update_Customer = `UPDATE Customer SET ${firstname} ${lastname} ${dateofbirth} ${number_of_indentification_document} ${type_of_indentification_document} ${issuing_authority} WHERE NFC_ID=${NFC_ID};`
            
    const deletePhones = `DELETE FROM Customer_phones WHERE NFC_ID=${NFC_ID};`
    const deleteEmails = `DELETE FROM Customer_emails WHERE NFC_ID=${NFC_ID};`

    db.query(update_Customer, (err, rows) => {
        if(err) res.status(400).send(err.message) 
        else {
            db.query(deletePhones, async (err2, rows) => {
                if(err2) res.status(400).send(err2.message) 
                else {
                    await phones.forEach(phone => {
                        db.query(`INSERT INTO Customer_phones VALUES (${NFC_ID},'${phone}');`)
                    })
                }
            })

            db.query(deleteEmails, async (err3, rows) => {
                if(err3) res.status(400).send(err3.message) 
                else {
                    await emails.forEach(email => {
                        db.query(`INSERT INTO Customer_emails VALUES (${NFC_ID},'${email}');`)
                    })
                }
            })
            res.send({"NFC_ID": NFC_ID})
        }
    })
}
exports.updateCustomer = updateCustomer


function deleteCustomer (req, res) {
    delete_Customer = `DELETE FROM Customer WHERE NFC_ID=${req.params.NFC_ID};`
    db.query(delete_Customer, (err, rows) => {
        if(err) res.status(400).send(err.message) 
        else {
            db.query(`DELETE FROM Customer_phones WHERE NFC_ID=${req.params.NFC_ID};`)
            db.query(`DELETE FROM Customer_emails WHERE NFC_ID=${req.params.NFC_ID};`)
            res.send()
        }
    })
}
exports.deleteCustomer = deleteCustomer