const mongoose = require('mongoose');

const rideRequestSchema = mongoose.Schema(
    {
        travelerId : { type: String, required: true },
        title : { type: String, required: true, unique: true, trim: true },
        //description : { type: String, required: true, trim: true },
        /*images: [
            { 
                type: String, 
                required: true,
            },
        ],*/
        addressFrom : { type: String, required: true},
        addressTo : { type: String, required: true},
        whishedDate : { type: String, required: true},        
        price : { type: Number, required: true},
    },    
    //created at times and updated at times
    {
    timestamps: true,
    }
);
const RideRequest = mongoose.model("RideRequest", rideRequestSchema);
module.exports = RideRequest;