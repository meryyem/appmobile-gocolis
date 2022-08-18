const express = require('express');
const senderRouter = express.Router();
const sender = require('../middlewares/sender');
const DeliveryRequest = require("../models/deliveryRequest");


// Add DeliveryRequest
senderRouter.post('/api/sender/add-delivery-request', sender, async (req, res) => {
    try {
        const {
            title, description, addressFrom, addressTo, whishedDate, price, size, images, senderId 
        } = req.body;

        let deliveryRequest = new DeliveryRequest({
            title, description, addressFrom, addressTo, whishedDate, price, size, images, senderId 
        });

        deliveryRequest = await deliveryRequest.save();
        res.json(deliveryRequest);

    } catch(e) {
        res.status(500).json({ error : e.message });
    }
});

// Get ALL DeliveryRequests
senderRouter.get('/api/sender/get-delivery-request', sender, async (req, res) => {
    try {
        const deliveryRequests = await DeliveryRequest.find({});
        console.log(deliveryRequests);
        res.json(deliveryRequests);
    } catch(e) {
        res.status(500).json({ error: e.message });
    }
  });

// Delete The DeliveryRequest
senderRouter.post('/api/sender/delete-delivery-request', sender, async (req, res) => {
    try {
        const {id} = req.body;
        let deliveryRequest = await DeliveryRequest.findByIdAndDelete(id);
        res.json(deliveryRequest);
    } catch(e) {
        res.status(500).json({ error: e.message });
    }
});

//UPDATE Delivery
senderRouter.post('/api/sender/update-delivery-request', sender, async (req, res) => {

    try {
        const {id, title, description, addressFrom, addressTo, whishedDate, price, size,} = req.body;
        //const {id, title, description, addressFrom, addressTo, whishedDate, price, size, images,} = req.body;
        let updatedDeliveryRequest = await DeliveryRequest.findById(id);
        updatedDeliveryRequest.title = title;
        updatedDeliveryRequest.description = description;
        updatedDeliveryRequest.addressFrom = addressFrom;
        updatedDeliveryRequest.addressTo = addressTo;
        updatedDeliveryRequest.whishedDate = whishedDate;
        updatedDeliveryRequest.price = price;
        updatedDeliveryRequest.size = size;
        //updatedDeliveryRequest.images = images;

        updatedDeliveryRequest= await updatedDeliveryRequest.save();
         
        res.json(updatedDeliveryRequest);
    } catch(err) {
        res.status(500).json(err);
    }
});

module.exports = senderRouter;
