const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();

const userController = require("../controllers/auth.controller");

const auth = require("../middlewares/auth");

const User = require("../models/user");


// SIGN UP
authRouter.post('/api/auth/register', async (req, res) => {
    try {
        const {firstName, lastName, email, password, birthDate, phoneNumber, authType, userType } = req.body;

        const existingUser = await User.findOne({ email });

        if(existingUser) { 
            return res.status(400).json({msg: "User with same email already exists !"}); 
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({
            authType, 
            firstName, 
            lastName, 
            email, 
            password: hashedPassword, 
            birthDate, 
            phoneNumber, 
            userType
        });

        user = await user.save();
        
        res.json(user);

    } catch(e) {
        res.status(500).json({ error: e.message });
    }
});

// LOGIN
authRouter.post('/api/auth/login', async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });

        if(!user) {
            return res.status(400).json({msg: 'User with this email does not exist!'});
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if(!isMatch) {
            return res.status(400).json({msg: 'Incorrect password.!'});
        }

        //this key will be used to verify the requests
        const token = jwt.sign({id: user._id}, "passwordKey");
        // ... => object destructuring 
        res.json({token, ...user._doc});

    } catch(e) {
        res.status(500).json({ error: e.message });
    }
});


// TOKEN VALID ?
authRouter.post('/api/auth/isTokenValid', async (req, res) => {
    try {
        //token will be passed through header
        const token = req.header('x-auth-token');
        if(!token) return res.json(false);

        jwt.verify(token, 'passwordKey');
        const isVerified = jwt.verify(token, 'passwordKey');
        if(!isVerified) return res.json(false);

        const user = await User.findById(isVerified.id);
        if(!user) return res.json(false);
        res.json(true);

    } catch(e) {
        res.status(500).json({ error: e.message });
    }
});

// GET USER DATA ---------------------------------------------------------------------------------------
// auth middleware will make sure that you are authorized
authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
});



// ----------------------------------------------------------

// SIGN UP
authRouter.post('/api/auth/socialRegister', async (req, res) => {
    try {
        const {firstName, lastName, email, password, birthDate, phoneNumber, authType, userType } = req.body;
        
        const existingUser = await User.findOne({ email });

        if(existingUser) { 
            return res.status(400).json({msg: "User with same email already exists !"}); 
        }

        //const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({
            authType: 'fb&gmail', 
            firstName, 
            lastName: 'fb&gmail', 
            email, 
            password: 'fb&&gmail', 
            birthDate: 'fb&gmail', 
            phoneNumber: '', 
            userType: 'sender'
        });

        user = await user.save();
        
        res.json(user);

    } catch(e) {
        res.status(500).json({ error: e.message });
    }
});


// SOCIAL LOGIN
// LOGIN
authRouter.post('/api/auth/socialLogin', async (req, res) => {
    try {
        const password = '';
        const authType = 'socialLogin';
        const userType = 'sender';
        const { email,} = req.body;
    

        const user = await User.findOne({ email });

        if(!user) {
            return res.status(400).json({msg: 'User with this email does not exist!'});
        }

        /*const isMatch = await bcryptjs.compare(password, user.password);
        if(!isMatch) {
            return res.status(400).json({msg: 'Incorrect password.!'});
        }*/

        //this key will be used to verify the requests
        const token = jwt.sign({id: user._id}, "passwordKey");
        // ... => object destructuring 
        res.json({token, ...user._doc});

    } catch(e) {
        res.status(500).json({ error: e.message });
    }
});



// SOCIAL LOGIN
// LOGIN
authRouter.post('/api/auth/social',  async (req, res) => {
    try {
        const {firstName, lastName, email, password, birthDate, phoneNumber, authType, userType, image} = req.body;
        const token = req.header('x-auth-token');
        const existingUser = await User.findOne({ email });

        
        if (!existingUser) {
            let user = new User({
                authType: 'fb&gmail', 
                firstName, 
                lastName: 'fb&gmail', 
                email, 
                password: 'fb&&gmail', 
                birthDate: 'fb&gmail', 
                phoneNumber: '151515', 
                userType: 'sender',
                image,
            });
    
            user = await user.save();
            
            res.json(user);
            //----
            return res.json({token, ...user._doc});
    
        
        } else if(existingUser) { 
            const token = jwt.sign({id: existingUser._id}, "passwordKey"); 
            return res.json({token, ...existingUser._doc});
            //return res.status(400).json({msg: "User with same email already exists !"}); 
    } 
    }catch(e) {
        res.status(500).json({ error: e.message });
    }

        //const hashedPassword = await bcryptjs.hash(password, 8);

        
    
});




authRouter.post('/api/auth/otpCreate', userController.createOtp);
authRouter.post('/api/auth/otpVerify', userController.verifyOtp);



module.exports = authRouter;