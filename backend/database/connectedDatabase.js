const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: process.env.DB_HOSTNAME,
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

async function databaseConnect() {
  try {
    const connection = await pool.getConnection();
    console.log('Connected to MySQL database');
    connection.release(); // Release the connection back to the pool
  } catch (err) {
    console.error('Error connecting to MySQL:', err);
  }
}

async function queryDb(sql, values) {
  try {
    const connection = await pool.getConnection();
    const [result] = await connection.execute(sql, values);
    connection.release(); // Release the connection back to the pool
    return result;
  } catch (err) {
    throw err;
  }
}

module.exports = { databaseConnect, queryDb };
