const express = require("express");

//otp generator-------------------------
const otpGenerator = require("otp-generator");
const crypto = require("crypto");
//this key will be used for generating the hash
const key = "otp-secret-key";

//const msg91 = require("msg91")("API_KEY", "SENDER_ID", "ROUTE_NO");


// OTP GENERATOR --------------------------------------------------------------------------------------------
async function createOtp(params, callback) {
    const otp = otpGenerator.generate(4, { 
        alphabets: false,
        lowerCaseAlphabets: false,
        upperCaseAlphabets: false,
        specialChars: false,
    });

    // time to expire = 5min
    const ttl = 5 * 60 * 60 * 1000; 
    const expires = Date.now() + ttl;

    const data = `${params.phone}.${otp}.${expires}`;

    const hash = crypto.createHmac("sha256", key).update(data).digest("hex");

    const fullHash = `${hash}.${expires}`;

    console.log(`Your OTP is ${otp}`);

    //SEND SMS;
   /* msg91.send(params.phone, "Your OTP is ${otp}", function (err, response) {
        console.log(err);
        console.log(response);
    });*/
    return callback(null, fullHash);
}


// VERIFY OTP ------------------------------------------------------------------------------------------------
async  function verifyOTP(params, callback) {
    let [hashValue, expires] = params.hash.split('.');

    let now = Date.now();
    if(now > parseInt(expires)) return callback("OTP Expired !!!");

    let data = `${params.phone}.${params.otp}.${expires}`;
    let newCalculateHash = crypto
    .createHmac("sha256", key)
    .update(data)
    .digest("hex");

    if(newCalculateHash != hashValue) {
        return callback("Invalid OTP !");
    }
    return callback(null, "Success");
    
}

module.exports = {
    createOtp, verifyOTP
}