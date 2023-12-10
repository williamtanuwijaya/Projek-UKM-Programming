let express = require('express');
const { sendResetEmail } = require('../../public/javascripts/sendResetEmail');
const { queryDb } = require('../../database/connectedDatabase');
let router = express.Router();
let crypto = require('crypto');

router.post('/', async (req, res) => {
  try {
    const { email } = req.body;

    // Check if email exists
    const user = await queryDb('SELECT * FROM users WHERE email = ?', [email]);
    if (user.length === 0) {
      return res.status(404).json({ error: 'Email not found' });
    }

    // Generate a unique reset token
    const resetToken = crypto.randomBytes(32).toString('hex');

    // Save the reset token in the database
    await queryDb('UPDATE users SET reset_token = ? WHERE email = ?', [resetToken, email]);

    // Send reset email
    sendResetEmail(email, resetToken);

    res.status(200).json({ message: 'Reset email sent successfully', resetToken });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
