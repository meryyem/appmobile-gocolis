//IMPORT FROM PACKAGES
const express = require('express');
const mongoose = require('mongoose');
const morgan = require('morgan');
const dotenv = require('dotenv');


//INIT
const app = express();
dotenv.config();



// api to use the image on the other user app
// i need to make the uploads folder as a static and create an endpoint
// which help me to access all of the images which i stored on this uploads folder

// so to make any folder static and to get access of any folder => use the app.use
app.use("/uploads", express.static("uploads"));


//for the chat part
const cors = require('cors');
var http = require('http');
var server = http.createServer(app);
//initialize the socket by passing the server property that i created ! in an io variable !!!!
//to run a socket io i will need the http server
var io = require('socket.io')(server, {
    //i will provide an object => the cors
    //and i will set the origin of the cors star
    cors: 
    {
        origin: "*"
    }

});


//IMPORT FROM OTHER FILES
const authRouter = require('./routes/auth');
const senderRouter = require('./routes/sender');
const travelerRouter = require('./routes/traveler');
const profileRouter = require('./routes/profile');
const messageRouter = require('./routes/message');


//MIDDLEWARES
//for decoding the data
app.use(express.json());
//allow the cors (chat part)
//app.use(cors());

//middleare to make the uploads folder static // if the uploads folder is static then it will be accessible from the url 
app.use("/uploads", express.static("uploads"));
//----
app.use(authRouter);
//app.use(adminRouter);
app.use(senderRouter);
app.use(travelerRouter);
app.use(profileRouter);
app.use(messageRouter);


var clients = {};
//CONNECTION
io.on("connection", (socket) => {
    console.log("connected");
    // to get the user id
    console.log(socket.id, "has joined");
    //listenning to the event named chat
    //in the message we will get the id from the front end code
    socket.on('chat', (id) => {
        //to get the message sent from the front !!
        console.log(id);
        //clients is a map (type)
        //the key of the map is id and the value is socket
        clients[id] = socket;
        console.log(clients);
    });
    socket.on('message', (msg) => {
        console.log(msg);
        let targetId = msg.targetId;
        //now i have to find the socket object of the target
        if(clients[targetId]) clients[targetId].emit('message', msg);
    });
});

server.listen(process.env.PORT,"0.0.0.0", function () {
    console.log(`Server Started at port ${process.env.PORT}`);
});



//CONNECTION
mongoose
    .connect(process.env.DB)
    .then(() => {
        console.log("Connection Successful");
    })
    .catch((e) => {
        console.log(e);
    });

/*app.listen(process.env.PORT,"0.0.0.0", function () {
    console.log(`Connected at port ${process.env.PORT}`);
});*/

