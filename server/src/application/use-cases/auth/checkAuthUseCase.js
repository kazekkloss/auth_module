const { UserNotFoundError } = require("../../../errors/customError");

class CheckAuthUseCase {
  constructor(authRepository) {
    this.authRepository = authRepository;
  }
  async execute(userId) {
    const user = await this.authRepository.findUserById(userId);
    if (!user) {
      throw new UserNotFoundError("User not found");
    }
    console.log(user);
    return user;
  }
}

module.exports = CheckAuthUseCase;
