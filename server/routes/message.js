const express = require('express');
const messageRouter = express.Router();
const multer = require('multer');



// create a storage object
const storage = multer.diskStorage({
    // the first thing specify the destination
    // the destination parameter will return a method and in the method i will get three property
    // the first one is req  : the req i will passed here
    // 2 - the file : the file i will upload from flutter app will come here
    // 3 - the callback
    destination:(req, file, callback) => {
        //in the cb the first thing is null and the second thing is the directory where i will store the image
        callback(null, "./uploads");
    },

    // the second parameter is the filename and again i will use 3 parameters
    filename:(req, file, callback) => {
        // filename 
        callback(null, Date.now() + ".jpg");
    }
});

// create a multer object
const upload = multer({
    //first thing i have to provide the storage object to the multer object
    storage: storage,
});

// ADD IMAGE
messageRouter.post("/api/message/addImage", upload.single("img"), (req, res) => {
    // key is img , i will use at the time of sending the image from the front end to the backend
    // send the path of the image to the flutter app
    try {
        res.json({path : req.file.filename});
    } catch(e) {
        return  res.json({eror : e});
    }

});

module.exports = messageRouter;