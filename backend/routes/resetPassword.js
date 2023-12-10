let express = require('express');
const { queryDb } = require('../database/queryDb');
let router = express.Router();
const bcrypt = require('bcrypt');

router.post('/', async (req, res) => {
  try {
    const { email, token, newPassword } = req.body;

    // Check if email and token match
    const user = await queryDb('SELECT * FROM users WHERE email = ? AND reset_token = ?', [email, token]);
    if (user.length === 0) {
      return res.status(401).json({ error: 'Invalid email or token' });
    }

    // Hash the new password before saving it to the database
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // Update password and reset token in the database
    await queryDb('UPDATE users SET password = ?, reset_token = NULL WHERE email = ?', [hashedPassword, email]);

    res.status(200).json({ message: 'Password reset successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
