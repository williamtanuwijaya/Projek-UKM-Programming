let express = require('express');
let router = express.Router();
const { queryDb } = require('../database/connectedDatabase');

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

module.exports = router;
