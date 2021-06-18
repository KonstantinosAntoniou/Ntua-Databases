module.exports = (app) => {
    const { insertCustomer, updateCustomer, deleteCustomer, getCustomer, getAllCustomers} = require('../controller/customerController.js')
    const { insertRoom, updateRoom, deleteRoom, getRoom, getAllRooms} = require('../controller/roomsController.js')
    const { insertService, updateService, deleteService, getService, getAllServices, getServiceVisitsWithCriteria} = require('../controller/servicesController.js')
    const {trackCustomersVisits, detectPossibleCovidCases, mostUsedRooms, mostUsedServices, servicesUsedByTheMostPeople} = require('../controller/trackingController.js')
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



    app.route('/db/api/services')
        .get(getAllServices)
        .post(insertService);    

    app.route('/db/api/services/:service_ID')
        .get(getService)
        .put(updateService)
        .delete(deleteService);



    app.route('/db/api/servicesCriteria/:service_ID/:amount/:date_time_of_entrance/:must_register')
        .get(getServiceVisitsWithCriteria);



    app.route('/db/api/tracking/:NFC_ID')
        .get(trackCustomersVisits);

    app.route('/db/api/detectCovid/:NFC_ID')
        .get(detectPossibleCovidCases);


        
    app.route('/db/api/mostUsedRooms')
        .get(mostUsedRooms);

    app.route('/db/api/mostUsedServices')
        .get(mostUsedServices);

    app.route('/db/api/servicesUsedByTheMostPeople')
        .get(servicesUsedByTheMostPeople);
}
