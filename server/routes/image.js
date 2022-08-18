/*const express = require('express');
const multer = require('multer');
const GridFsStorage = require('multer-gridfs-storage');
const GridStream = require('gridfs-stream');
const crypto = require('crypto');
const mongoose = require('mongoose');
const imageRoute = express.Router();


let Gfs = null;
let storage = null;

/*connection().then(() => {
    const conn = mongoose.createConnection()
})*/
//i will work with my Grid Stream
//Gfs = GridStream(conn.db, mongoose.mongoose());
/*Gfs.collection('imagesUploads');*/

//Mongo Url and File
/*storage = new GridFsStorage({
    url: process.env.DB,
    file: (req, file) => {
        return new Promise((resolve, reject) => {
            //We will use crypto here to create the bytes 
            crypto.randomBytes(16, (err, buff) => {
                
            })
        });
    }
});
*/