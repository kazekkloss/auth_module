const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  verify: { type: Boolean, default: false },
  token: { type: String, default: '' } // Dodanie pola token
});

const User = mongoose.model("User", userSchema);

module.exports = User;
