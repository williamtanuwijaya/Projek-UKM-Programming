let express = require('express');
let router = express.Router();
let path = require('path');
const { queryDb } = require('../../database/connectedDatabase');
const bcrypt = require('bcrypt');
const multer  = require('multer');


const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, __dirname + '/uploads')
  },
  filename: function (req, file, cb) {
    // const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
    cb(null, file.originalname)
  }
});

const upload = multer({ storage: storage });

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

// PATCH route to partially update a user by ID without updating the password
router.patch("/:userId", async (req, res) => {
  try {
    const userId = req.params.userId;
    const { email, username, phone, name, confirmPassword } = req.body;
      
    if (userId) {
      // Confirm the password before proceeding with the update
      const getUserPasswordQuery = 'SELECT password FROM users WHERE id = ?';
      const userPasswordResult = await queryDb(getUserPasswordQuery, [userId]);
      const isPasswordValid = await bcrypt.compare(confirmPassword, userPasswordResult[0].password);

      if (!isPasswordValid) {
        return res.status(401).json({ error: 'Invalid password confirmation' });
      }
      if (req.body.email) {
        const updateUserQuery = 'UPDATE users SET email = ? WHERE id = ?';
        await queryDb(updateUserQuery, [email, userId]);
      }
      if (req.body.username) {
        const updateUserQuery = 'UPDATE users SET username = ? WHERE id = ?';
        await queryDb(updateUserQuery, [username, userId]);
      }
      if (req.body.phone) {
        const updateUserQuery = 'UPDATE users SET phone = ? WHERE id = ?';
        await queryDb(updateUserQuery, [phone, userId]);
      }
      if (req.body.name) {
        const updateUserQuery = 'UPDATE users SET name = ? WHERE id = ?';
        await queryDb(updateUserQuery, [name, userId]);
      }
      res.status(200).json({ message: 'User updated successfully' });
    } else {
      res.status(404).json({ error: 'User not found' });
    } 
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

//PATCH route to add/update profile picture to user
// router.patch("/foto/:userId", async (req, res) => {
//   try {
//     const userId = req.params.userId;
//     const { filename, path } = req.body;
//     const host = req.host;
//     const filePath = req.protocol + "://" + host + '/' + req.file.path;
      
//     if (userId) {
//       if (req.body.filename) {
//         const updateUserQuery = 'UPDATE users SET filename = ? WHERE id = ?';
//         await queryDb(updateUserQuery, [filename, userId]);
//       }
//       if (req.body.path) {
//         const updateUserQuery = 'UPDATE users SET path = ? WHERE id = ?';
//         await queryDb(updateUserQuery, [path, userId]);
//       }
//       res.status(200).json({ message: 'profile picture updated successfully' });
//     } else {
//       res.status(404).json({ error: 'User not found' });
//     } 
//   } catch (error) {
//     console.error(error);
//     res.status(500).json({ error: 'Internal server error' });
//   }
// });

//POST route to upload photo using multer
router.post('/profile/:userId', upload.single('avatar'), async (req, res) => {
  // req.file is the `avatar` file
  // req.body will hold the text fields, if there were any
  try {
    const userId = req.params.userId;
    const filename = req.file.originalname;
    const path = req.file.destination;
    // const host = req.host;
    // const filePath = req.protocol + "://" + host + '/' + req.file.path;
      
    if (userId) {
      if (req.body.filename) {
        const updateUserQuery = 'UPDATE users SET filename = ? WHERE id = ?';
        await queryDb(updateUserQuery, [filename, userId]);
      }
      if (req.body.path) {
        const updateUserQuery = 'UPDATE users SET path = ? WHERE id = ?';
        await queryDb(updateUserQuery, [path, userId]);
      }
      res.status(200).json({ message: 'profile picture updated successfully' });
    } else {
      res.status(404).json({ error: 'User not found' });
    } 
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
