let express = require('express');
let router = express.Router();
const { queryDb } = require('../../database/connectedDatabase');
const bcrypt = require('bcrypt');

router.get('/', async (req, res) => {
  try {
    const getUsersQuery = 'SELECT * FROM users';
    const users = await queryDb(getUsersQuery);
    res.status(200).json({ users });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET route to retrieve a user by ID
router.get('/:userId', async (req, res) => {
  try {
    const userId = req.params.userId;
    const getUserByIdQuery = 'SELECT * FROM users WHERE id = ?';
    const user = await queryDb(getUserByIdQuery, [userId]);

    if (user.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.status(200).json({ user });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// DELETE route to delete a user by ID
router.delete('/:userId', async (req, res) => {
  try {
    const userId = req.params.userId;
    const deleteUserQuery = 'DELETE FROM users WHERE id = ?';
    await queryDb(deleteUserQuery, [userId]);
    res.status(200).json({ message: 'User deleted successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// PUT route to update a user by ID without updating the password
router.put('/:userId', async (req, res) => {
  try {
    const userId = req.params.userId;
    const { email, username, phone, name, confirmPassword } = req.body;

    // Confirm the password before proceeding with the update
    const getUserPasswordQuery = 'SELECT password FROM users WHERE id = ?';
    const userPasswordResult = await queryDb(getUserPasswordQuery, [userId]);

    if (userPasswordResult.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    const isPasswordValid = await bcrypt.compare(confirmPassword, userPasswordResult[0].password);

    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Invalid password confirmation' });
    }

    // Update user in the database without updating the password
    const updateUserQuery = 'UPDATE users SET email = ?, username = ?, phone = ?, name = ? WHERE id = ?';
    await queryDb(updateUserQuery, [email, username, phone, name, userId]);

    res.status(200).json({ message: 'User updated successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
