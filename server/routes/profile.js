const express = require("express");
const Profile = require("../models/profile");
const profileRouter = express.Router();
const auth = require('../middlewares/auth');
const multer = require("multer");
const Path = require("path");

// MULTER CONFIGURATION
//create an instance of the multer storage
const storage = multer.diskStorage({
    //define the file name and the path
    destination: (req, file, callback) => {
        callback(null, "./uploads");
    },
    filename: (req, filename, callback) => {
        callback(null, req.decoded.email + ".jpg");
    },

});
//create an instance of the fileFilter
const fileFilter = (req, file, callback) => {
    if (file.mimetype == "image/jpeg" || file.mimetype == "image/png" ) {
        callback(null, true);
    } else {
        callback(null, false);
    }
};
//create an instance of the multer package
const upload = multer({
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 6,
    },
    fileFilter: fileFilter
});

// adding and update profile image
profileRouter.patch("/api/addImage", auth, upload.single("img"), (req, res) => {
    Profile.findOneAndUpdate(
        {
            email : req.email,
        },
        {
            $set: {
                img: req.file.Path,
            },
        },
        {
            new: true,
        },
        (err, profile) => {
            if (err ) return res.status(500).send(err);
            const response = {
                message: "image added successfully updated",
                data: profile,
            };
            return res.status(200).send(response);
        }
    );
});

profileRouter.post("/api/addProfile", auth, (req, res) => {
    const profile = Profile({
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        email: req.body.email,
        phoneNumber: req.body.phoneNumber,
        birthDate: req.body.birthDate,
        userId: req.body.userId,
        image: req.body.image
    });
    
    profile.save().then(() => {
        return res.json({ msg: "profile successfully stored" });
    })
    .catch((err) => {
        return res.status(400).json({ err: err });
    });
    console.log(profile);
});

// check profile data
profileRouter.get("/api/checkProfile", auth, async (req, res) => {
    //await Profile.findOne({ email : req.email })
    try {
        await Profile.find({})
        .then(function (err, result) {
            //console.log(email);
            if(!err) {
                if(result == null ) return res.json({ status : false });
                return res.json({ status: true });
            } /*else {
                throw err;
            }*/
        });

    }catch (err) {
        res.status(500).json({ error: err.message });
    }
});

/*
try {
        const deliveryRequests = await DeliveryRequest.find({});
        console.log(deliveryRequests);
        res.json(deliveryRequests);
    } catch(e) {
        res.status(500).json({ error: e.message });
    }
*/

//get Profile data
/*profileRouter.get("/api/profileData", auth, async (req,res) => {
    await Profile.findOne({ email : req.email }, (err, result) => {
        if (err) return res.json({err : err});
        if(result == null ) return res.json({ data: [] });
        else return res.json({ data: result});
    });
});*/

/*profileRouter.get("/api/profileData", auth, async (req,res) => {
    Profile.findOne({ email : req.email })
    .then(function (err, result) {
            if (!err) {
                if(result == null ) return res.json({ data: [] });
                else return res.json({ data: result});
                //res.render("retrieve", { title: "View Profile Data", records: data });
            } else {
                throw err;
            }
        });
});*/

// Get ALL DeliveryRequests
/*profileRouter.get('/api/profileData', auth, async (req, res) => {
    try {
        const {email} = req.body;
        const profile = await Profile.findOne({ email})
        console.log(profile);
        res.json(profile);
    } catch(e) {
        res.status(500).json({ error: e.message });
    }
  });*/

// GET PROFILE DATA
profileRouter.post('/api/profileData', auth, async (req, res) => {
    try {
        const {email} = req.body;
        const profile = await Profile.findOne({email});
        /*if(!profile) {
            return res.status(400).json({msg: 'Profile with this email does not exist!'});
        }*/
        res.json(profile);
    } catch(e) {
        res.status(500).json({ error: e.message });
    }
});


// update profile data
profileRouter.patch("/api/updateProfileData", auth, async (req, res) => {
    let profile = {};
    await Profile.findOne({ email : req.email }, (err, result) => {
        if (err) {
            profile = {};
        }
        if(result !=  null ) {
            profile = result;
        };
    });
    Profile.findOneAndUpdate({ email : req.email },
        {
            $set: {
               firstName: req.body.firstName ? req.body.firstName : profile.firstName, 
               lastName: req.body.lastName ? req.body.lastName : profile.lastName,
               email: req.body.email ? req.body.email : profile.email,
               phoneNumber: req.body.phoneNumber ? req.body.phoneNumber : profile.phoneNumber,
               birthDate: req.body.birthDate ? req.body.birthDate : profile.birthDate,
               image: req.body.image ? req.body.image : profile.image,
            },
        },
        {
            new: true,
        },
        (err, result) => {
            if (err) return res.json({err : err});
            if(result == null ) return res.json({ data: [] });
            else return res.json({ data: result});
        }
        );
});

module.exports = profileRouter;