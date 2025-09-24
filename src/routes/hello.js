const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  const name = req.query.name || 'World';
  res.send(`Hello, ${name}!`);
});

module.exports = router;
