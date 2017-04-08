var express = require('express');
var router = express.Router();
var sha512sum = require('sha512sum');
var multer  = require('multer');
var upload = multer({ dest: 'uploads/' });
var web3 = require('web3');

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
  var hashString = '';
  console.log("%s uploaded as %s at %s.",req.file.originalname,req.file.filename,req.file.path);

  sha512sum.fromFile(req.file.path,{sep: '|'},function(err,hash) {
    if (err) throw err;
    hashString = hash.substring(0,hash.indexOf('|'));
    console.log('Generated hash: ' + hashString);
    res.end('<pre><h3>Artefact signing successful. Signature generated: ' + hashString+'</h3></pre>');
  });
  console.log('Processing done.')
});

module.exports = router;
