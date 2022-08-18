//IMPORT FROM PACKAGES
const express = require('express');
const mongoose = require('mongoose');
const morgan = require('morgan');
const dotenv = require('dotenv');



//IMPORT FROM OTHER FILES
const authRouter = require('./routes/auth');
const senderRouter = require('./routes/sender');
const travelerRouter = require('./routes/traveler');
const profileRouter = require('./routes/profile');


//INIT
const app = express();
dotenv.config();


//MIDDLEWARES
app.use(express.json());
//middleare to make the uploads folder static // if the uploads folder is static then it will be accessible from the url 
app.use("/uploads", express.static("uploads"));
//----
app.use(authRouter);
//app.use(adminRouter);
app.use(senderRouter);
app.use(travelerRouter);
app.use(profileRouter);


//CONNECTION
mongoose
    .connect(process.env.DB)
    .then(() => {
        console.log("Connection Successful");
    })
    .catch((e) => {
        console.log(e);
    });

app.listen(process.env.PORT,"0.0.0.0", function () {
    console.log(`Connected at port ${process.env.PORT}`);
});