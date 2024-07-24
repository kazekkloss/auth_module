const { UserAlreadyExistsError, MailError } = require("../../../errors/customError");

class SignUpUseCase {
  constructor(authRepository, mailService) {
    this.authRepository = authRepository;
    this.mailService = mailService;
  }

  async execute(email, password) {
    const existingUser = await this.authRepository.findUserByEmail(email);
    if (existingUser) {
      throw new UserAlreadyExistsError("User already exists");
    }

    const hashedPassword = await this.authRepository.hashPassword(password);
    const user = await this.authRepository.createUser({ email, password: hashedPassword });

    try {
      await this.mailService.sendVerifyMail(email, user._id);
    } catch (error) {
      await this.authRepository.deleteUser(user._id); 
      throw new MailError("Failed to send verification email");
    }

    return { token: "dummy_token", email: user.email };
  }
}

module.exports = SignUpUseCase;
