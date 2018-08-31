const express = require('express');
const path = require('path');
const multer = require('multer');
const child_process = require("child_process");

const app = express();

const port = process.env.PORT || 3000;

// Getting POST routes
//const upload = require('./server/routes/uploader');

// Set static folder
app.use(express.static(path.join(__dirname, 'dist/file-upload')));

//app.use('/upload', upload);

app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

// Defining image location and name
const storage = multer.diskStorage({
    destination: './public/uploads',
    filename: function (req, file, cb) {
      cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
    }
  });

const images = multer({
     storage: storage,
     fileFilter: function(req, file, cb) {
        // Only accepts jpeg type images for R script
        if (file.mimetype === 'image/jpeg') {
            cb(null, true);
        } else {
            cb(null, false);
        }
    }
}).single("eyeImage");

app.post("/upload", images, function (req, res) {
    
    // Create child process running an R script - [script path, args]
    const spawn = child_process.spawn("Rscript", ["./src/scripts/test_script.R", req.file.path]);

    // Output of child
    spawn.stdout.on("data", data => {
        res.send({"stdout": data.toString()});
    });
    // Error of child
    spawn.stderr.on("data", data => {
        console.log({"stderr": data.toString()});
    });
    spawn.stdin.on("data", data => {
        res.send({"stdin": data.toString()});
    });
    //res.send({"Hi": req.file});
});

// Catch all other route request and return to the index
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'dist/file-upload/index.html'));
});

app.listen(port, (req, res) => {
    console.log('running on port ' + port);
});