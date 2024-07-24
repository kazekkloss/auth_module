const mongoose = require("mongoose");

const DB = "mongodb+srv://milestory:04oeu8TrbKc8TRrg@milestory.6mfyucf.mongodb.net/?retryWrites=true&w=majority&appName=MileStory";

mongoose.connect(DB).then(() => {
  console.log("Connection with Database Successful");
}).catch((e) => {
  console.log(e);
});

module.exports = mongoose;