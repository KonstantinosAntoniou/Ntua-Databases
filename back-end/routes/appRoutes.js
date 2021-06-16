module.exports = (app) => {
    const { insertCustomer, updateCustomer, deleteCustomer} = require('../controller/customerController.js')
    const { insertRoom, updateRoom, deleteRoom, getRoom} = require('../controller/roomsController.js')
    const { insertService, updateService, deleteService} = require('../controller/servicesController.js')
    //const db = require('../server.js')
    const gett = require('../controller/roomsController.js')

    app.route('/db/api/customers')
        //.get(getClientList);
        .post(insertCustomer);    

    app.route('/db/api/customers/:customer')
        //.get(getClient);
        .put(updateCustomer)
        .delete(deleteCustomer);


        

    app.route('/db/api/rooms')
        //.get(getRoomList);
        .post(insertRoom);    

    app.route('/db/api/rooms/:hotel_room_ID')
        .get(getRoom);
        //.put(updateRoom);
        //.delete(deleteRoom);

    app.route('/db/api/rooms2/:hotel_room_ID')
        .get(gett.getRoom2);



        
    app.route('/db/api/services')
        //.get(getServiceList);
        .post(insertService);    

    app.route('/db/api/services/:service')
        //.get(getService);
        .put(updateService)
        .delete(deleteService);
}