const express = require('express');
const path = require('path');
const app = express();

// Serve static files (frontend)
app.use(express.static(path.join(__dirname, 'public')));

app.get('/api/message', (req, res) => {
  res.json({ msg: 'Hello... Hows it Going?' });
});

const helloRoute = require('./routes/hello.js');
app.use('/hello', helloRoute); // Mount /hello route

module.exports = app;
