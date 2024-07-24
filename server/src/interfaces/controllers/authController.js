const AuthService = require("../../application/services/authService");
const { CustomError } = require("../../errors/customError");
const path = require("path");

class AuthController {
  constructor() {
    this.authService = new AuthService();
  }

  async signUp(req, res) {
    try {
      const { email, password } = req.body;
      const result = await this.authService.signUp(email, password);
      res.status(200).json(result);
    } catch (e) {
      if (e instanceof CustomError) {
        return res.status(e.getStatusCode()).json({ message: e.message });
      }
      res.status(500).json({ error: "Internal Server Error" });
    }
  }

  async verifyUser(req, res) {
    try {
      const userId = req.query.id;
      await this.authService.verifyUser(userId);
      res.sendFile(path.join(__dirname, "../../templates/verify-page.html"));
    } catch (e) {
      if (e instanceof CustomError) {
        return res.status(e.getStatusCode()).json({ message: e.message });
      }
      res.status(500).json({ error: "Internal Server Error" });
    }
  }

  async signIn(req, res) {
    try {
      const { email, password } = req.body;
      const result = await this.authService.signIn(email, password);
      res.status(200).json(result);
    } catch (e) {
      if (e instanceof CustomError) {
        return res.status(e.getStatusCode()).json({ message: e.message });
      }
      res.status(500).json({ error: "Internal Server Error" });
    }
  }

  async checkAuth(req, res) {
    try {
      const user = await this.authService.checkAuth(req.userId);
      res.status(200).json(user);
    } catch (e) {
      if (e instanceof CustomError) {
        return res.status(e.getStatusCode()).json({ message: e.message });
      }
      res.status(500).json({ error: "Internal Server Error" });
    }
  }
}

module.exports = AuthController;
