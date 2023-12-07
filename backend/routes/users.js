let express = require('express');
let router = express.Router();

/* GET users listing. */
router.get('/', function (req, res, next) {
  res.send(process.env.APP_NAME);
});

router.get('/me', (req, res, next) => {
  res.send('Hi this me');
});
module.exports = router;
