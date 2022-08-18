const jwt = require('jsonwebtoken');
const User = require('../models/user');

const sender = async (req, res, next) => {
    try {
        //verify validation
        const token = req.header('x-auth-token');
        if(!token)
        return res.status(401).json({msg: "No auth token, access denied"});

        const verified = jwt.verify(token, 'passwordKey');
        if(!verified) return res.status(401).json({ msg : 'Token verification failed, authorization denied.'});

        const user = await User.findById(verified.id);
        if(user.userType == 'user' || user.userType == 'traveler') {
            return res.status(401).json({ msg : 'You are not a sender'});
        }

        //if verified => store user id 
        req.user = verified.id;
        req.token = token;
        next();
    } catch (err) {
        res.status(500).json({ error: err.message});
    }
}

module.exports = sender;