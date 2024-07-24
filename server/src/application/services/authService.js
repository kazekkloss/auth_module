const AuthRepositoryImpl = require("../../infrastructure/repositories/authRepositoryImpl");
const SignUpUseCase = require("../use-cases/auth/signUpUseCase");
const VerifyUserUseCase = require("../use-cases/auth/verifyUserUseCase");
const SignInUseCase = require("../use-cases/auth/signInUseCase");
const CheckAuthUseCase = require("../use-cases/auth/checkAuthUseCase");
const MailService = require("./mailService");

class AuthService {
  constructor() {
    const authRepository = new AuthRepositoryImpl();
    this.mailService = new MailService();
    this.signUpUseCase = new SignUpUseCase(authRepository, this.mailService);
    this.verifyUserUseCase = new VerifyUserUseCase(authRepository);
    this.signInUseCase = new SignInUseCase(authRepository);
    this.checkAuthUseCase = new CheckAuthUseCase(authRepository);
  }

  async signUp(email, password) {
    return await this.signUpUseCase.execute(email, password);
  }

  async verifyUser(userId) {
    return await this.verifyUserUseCase.execute(userId);
  }

  async signIn(email, password) {
    return await this.signInUseCase.execute(email, password);
  }

  async checkAuth(token) {
    return await this.checkAuthUseCase.execute(token);
  }
}

module.exports = AuthService;
