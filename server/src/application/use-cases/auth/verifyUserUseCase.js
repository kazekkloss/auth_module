const { UserNotFoundError } = require("../../../errors/customError");

class VerifyUserUseCase {
  constructor(authRepository) {
    this.authRepository = authRepository;
  }

  async execute(userId) {
    const user = await this.authRepository.findUserById(userId);
    if (!user) {
      throw new UserNotFoundError("User not found");
    }

    return await this.authRepository.updateVerifyStatus(userId, true);
  }
}

module.exports = VerifyUserUseCase;
