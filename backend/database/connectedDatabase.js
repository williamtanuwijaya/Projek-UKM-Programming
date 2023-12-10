const mysql = require('mysql2');
const { env } = require('process');

const databaseConnected = mysql.createConnection({
  host: env.DB_HOSTNAME,
  user: env.DB_USERNAME,
  password: env.DB_PASSWORD,
  database: env.DB_NAME,
});

function databaseConnect() {
  databaseConnected.connect((err) => {
    if (err) {
      console.error('Error connecting to MySQL:', err);
    } else {
      console.log('Connected to MySQL database');
    }
  });
}

module.exports = { databaseConnect };
