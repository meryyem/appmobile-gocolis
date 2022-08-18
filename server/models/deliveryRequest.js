const mongoose = require('mongoose');

const deliveryRequestSchema = mongoose.Schema(
    {
        senderId : { type: String, required: true },
        title : { type: String, required: true, unique: true, trim: true },
        description : { type: String, required: true, trim: true },
        images: [
            { 
                type: String, 
                required: true,
            },
        ],
        addressFrom : { type: String, required: true},
        addressTo : { type: String, required: true},
        whishedDate : { type: String, required: true},        
        price : { type: Number, required: true},
        size : { type: String },
    },    
    //created at times and updated at times
    {
    timestamps: true,
    }
);
const DeliveryRequest = mongoose.model("DeliveryRequest", deliveryRequestSchema);
module.exports = DeliveryRequest;