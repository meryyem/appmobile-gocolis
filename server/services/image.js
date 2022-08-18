/*const express = require ('express');


//---image upload code using multer
var storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, 'test');
    },
    filename: function(req, file, cb) {
        cb(null, Date.now() + '-' + file.originalname);
    }
});

var upload = multer({ storage: storage});

//--create new item 
app.post('/upload', upload.single('image'), (req, res) => {
    res.send(apiResponse({message: req.file.path}));
});

//--api response
function apiResponse(results) {
    return JSON.stringify({"status": 200, "error": null, "messages": results["messages"]});
}*/