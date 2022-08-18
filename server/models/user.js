const mongoose = require('mongoose');

const userSchema = new mongoose.Schema(
{
   // _id: mongoose.Schema.Types.ObjectId,
    userType: {
        type: String,
        required: true,
        default: 'user',
    },
    authType: {
        type: String,
        required: true,
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
    password: {
        type: String,
        required: true,
        validate: {
            validator: (value) => {
                return value.length > 8;
            },
            message: 'Please enter a long password',
        },
    },
    email: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return value.match(re);
            },
            message: 'Please enter a valid email address',
        },   
    },
    phoneNumber: {
        type: String,
        //default: ''
    },
    birthDate: {
        type: String,
        default: 10,
    },
},
//created at times and updated at times
{
timestamps: true,
},
);

const User = mongoose.model("User", userSchema);
module.exports = User;