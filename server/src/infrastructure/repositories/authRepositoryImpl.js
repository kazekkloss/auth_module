const User = require("../../domain/models/user");
const AuthRepository = require("../../domain/repositories/authRepository");
const bcrypt = require("bcrypt");

class AuthRepositoryImpl extends AuthRepository {
  async createUser(user) {
    const newUser = new User(user);
    return await newUser.save();
  }

  async findUserByEmail(email) {
    return await User.findOne({ email });
  }

  async findUserById(id) {
    return await User.findById(id);
  }

  async updateVerifyStatus(id, status) {
    return await User.findByIdAndUpdate(id, { verify: status }, { new: true });
  }

  async hashPassword(password) {
    const salt = await bcrypt.genSalt(10);
    return await bcrypt.hash(password, salt);
  }

  async comparePassword(inputPassword, storedPassword) {
    return await bcrypt.compare(inputPassword, storedPassword);
  }

  async updateToken(id, token) {
    return await User.findByIdAndUpdate(id, { token: token }, { new: true });
  }

  async deleteUser(id) {
    return await User.findByIdAndDelete(id);
  }
}

module.exports = AuthRepositoryImpl;
