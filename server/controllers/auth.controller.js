const express = require("express");

const authServices = require("../services/auth.services");

exports.createOtp = (req, res, next) => {
    authServices.createOtp(req.body, (error, results) => {
        if(error) {
            return next(error);
            next(error);
           // res.status(500).json({ error: e.message });
        }
        return res.status(200).send({ 
            message: "Success",
            data: results
        });
        //return res.status(200).json({msg: 'Success', data: results});
    })
}

exports.verifyOtp = (req, res, next) => {
    authServices.verifyOTP(req.body, (error, results) => {
        if(error) {
            //return next(error);
            next();
           return  res.status(500).json({ msg: 'Invalid OTP !', error : error});
        }
        /*return res.status(200).send({ 
            message: "Success",
            data: results
        });*/
        return res.status(200).json({msg: 'Success', data: results});
    })
}