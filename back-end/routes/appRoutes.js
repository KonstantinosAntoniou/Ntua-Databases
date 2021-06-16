module.exports = (app) => {
    const { insertCustomer, updateCustomer, deleteCustomer, getCustomer, getAllCustomers} = require('../controller/customerController.js')
    const { insertRoom, updateRoom, deleteRoom, getRoom, getAllRooms} = require('../controller/roomsController.js')
    const { insertService, updateService, deleteService, getService, getAllServices} = require('../controller/servicesController.js')
    //const gett = require('../controller/roomsController.js')

    app.route('/db/api/customers')
        .get(getAllCustomers)
        .post(insertCustomer);    

    app.route('/db/api/customers/:NFC_ID')
        .get(getCustomer)
        .put(updateCustomer)
        .delete(deleteCustomer);




    app.route('/db/api/rooms')
        .get(getAllRooms)
        .post(insertRoom);    

    app.route('/db/api/rooms/:hotel_room_ID')
        .get(getRoom)
        .put(updateRoom)
        .delete(deleteRoom);

    /*app.route('/db/api/rooms2/:hotel_room_ID')
        .get(gett.getRoom2);
    */


        
    app.route('/db/api/services')
        .get(getAllServices)
        .post(insertService);    

    app.route('/db/api/services/:service_ID')
        .get(getService)
        .put(updateService)
        .delete(deleteService);
}