const mongoose = require('mongoose');

const profileSchema = new mongoose.Schema({
    userId : { 
        type: String, 
        required: true , 
        unique: true
    },
    firstName: {
        type: String,
        required: true,
        trim: true,
    },
    lastName: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String, 
        required: true , 
        unique: true
    },
    phoneNumber: String,
    birthDate: String,
    image: {
        type: String,
        default: "",
    },
    
},
{
    timestamp: true,
},
);
const Profile = mongoose.model("Profile", profileSchema);
module.exports = Profile;