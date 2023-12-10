const { databaseConnect } = require('./connectedDatabase');

function queryDb(sql, values) {
  return new Promise((resolve, reject) => {
    databaseConnect.query(sql, values, (err, result) => {
      if (err) {
        reject(err);
      } else {
        resolve(result);
      }
    });
  });
}

module.exports = { queryDb };
