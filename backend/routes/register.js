let express = require('express');
let router = express.Router();
let bcrypt = require('bcrypt');
const { queryDb } = require('../database/queryDb');

router.post('/', async (req, res) => {
  try {
    const { email, username, password, phone, name } = req.body;

    // Check if email or username already exists
    const checkQuery = 'SELECT * FROM users WHERE email = ? OR username = ?';
    const existingUser = await queryDb(checkQuery, [email, username]);

    if (existingUser.length > 0) {
      return res.status(409).json({ error: 'Email or username already exists' });
    }

    // Hash the password before saving it to the database
    const hashedPassword = await bcrypt.hash(password, 10);

    const insertQuery = 'INSERT INTO users (email, username, password, phone, name) VALUES (?, ?, ?, ?, ?)';
    await queryDb(insertQuery, [email, username, hashedPassword, phone, name]);

    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;