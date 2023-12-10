let express = require('express');
const { queryDb } = require('../../database/connectedDatabase');
let router = express.Router();
let bcrypt = require('bcrypt');

router.post('/', async (req, res) => {
  try {
    const { username, password } = req.body;

    // Find user by username
    const selectQuery = 'SELECT * FROM users WHERE username = ?';
    const user = await queryDb(selectQuery, [username]);

    if (user.length === 0) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    // Check if the password is correct
    const isPasswordValid = await bcrypt.compare(password, user[0].password);
    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    res.status(200).json({ message: 'Login successful' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
