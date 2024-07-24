const mongoose = require("mongoose");

const DB = "";

mongoose.connect(DB).then(() => {
  console.log("Connection with Database Successful");
}).catch((e) => {
  console.log(e);
});

module.exports = mongoose;
