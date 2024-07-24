const jwt = require("jsonwebtoken");
const { UserNotFoundError, IncorrectPasswordError } = require("../../../errors/customError");

class SignInUseCase {
  constructor(authRepository) {
    this.authRepository = authRepository;
  }

  async execute(email, password) {
    const user = await this.authRepository.findUserByEmail(email);
    if (!user) {
      throw new UserNotFoundError("User with this email does not exist!");
    }

    const isMatch = await this.authRepository.comparePassword(password, user.password);
    if (!isMatch) {
      throw new IncorrectPasswordError("Incorrect password.");
    }

    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });

    return { token, user };
  }
}

module.exports = SignInUseCase;
