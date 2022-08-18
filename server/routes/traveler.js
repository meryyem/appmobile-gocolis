const express = require('express');
const travelerRouter = express.Router();
const traveler = require('../middlewares/traveler');
const RideRequest = require("../models/rideRequest");


// Add RideRequest
travelerRouter.post('/api/traveler/add-ride-request', traveler, async (req, res) => {
    try {
        const {
            title, addressFrom, addressTo, whishedDate, price, travelerId 
        } = req.body;

        let rideRequest = new RideRequest({
            title, addressFrom, addressTo, whishedDate, price, travelerId
        });

        rideRequest = await rideRequest.save();
        res.json(rideRequest);

    } catch(e) {
        res.status(500).json({ error : e.message });
    }
});

// Get ALL RideRequests
travelerRouter.get('/api/traveler/get-ride-request', traveler, async (req, res) => {
    try {
        const rideRequests = await RideRequest.find({});
        console.log(rideRequests);
        res.json(rideRequests);
    } catch(e) {
        res.status(500).json({ error: e.message });
    }
  });

// Delete The RideRequest
travelerRouter.post('/api/traveler/delete-ride-request', traveler, async (req, res) => {
    try {
        const {id} = req.body;
        let rideRequest = await RideRequest.findByIdAndDelete(id);
        res.json(rideRequest);
    } catch(e) {
        res.status(500).json({ error: e.message });
    }
});

//UPDATE Ride
travelerRouter.post('/api/traveler/update-ride-request', traveler, async (req, res) => {

    try {
        const {id, title, addressFrom, addressTo, whishedDate, price} = req.body;
        //const {id, title, description, addressFrom, addressTo, whishedDate, price, size, images,} = req.body;
        let updatedRideRequest = await RideRequest.findById(id);
        updatedRideRequest.title = title;
        updatedRideRequest.addressFrom = addressFrom;
        updatedRideRequest.addressTo = addressTo;
        updatedRideRequest.whishedDate = whishedDate;
        updatedRideRequest.price = price;
        //updatedRideRequest.images = images;

        updatedRideRequest= await updatedRideRequest.save();
         
        res.json(updatedRideRequest);
    } catch(err) {
        res.status(500).json(err);
    }
});

module.exports = travelerRouter;