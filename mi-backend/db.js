const { Pool } = require("pg");
require("dotenv").config();

const dbclient= new Pool({
  connectionString: process.env.DATABASE_URL
});

module.exports = { dbclient };