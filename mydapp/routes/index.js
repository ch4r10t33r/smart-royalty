var express = require('express');
var router = express.Router();
var sha512sum = require('sha512sum');
var multer  = require('multer')
var upload = multer({ dest: 'uploads/' })

/* GET home page. */
router.get('/', function(req, res) {
  //res.render('index', { title: 'Artefact Signing App' });
  res.sendfile('index.html');
});

router.post('/', upload.single('artefact'), function(req,res,ext) {
  /*
  console.log('%s file uploaded',req.file.filename);
  res.redirect('/?success=true');
  */
  console.log("%s uploaded as %s at %s.",req.file.originalname,req.file.filename,req.file.path);

  sha512sum.fromFile(req.file.path,function(err,hash) {
    if (err) throw err;
    console.log(hash);
  });
  res.write('successful');
});

module.exports = router;
