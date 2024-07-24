const express = require("express");
const AuthController = require("../../interfaces/controllers/authController");
const authMiddleware = require("../../middleware/authMiddleware");

const authRouter = express.Router();
const authController = new AuthController();

authRouter.post("/sign-up", (req, res) => authController.signUp(req, res));
authRouter.get("/verify", (req, res) => authController.verifyUser(req, res));
authRouter.post("/sign-in", (req, res) => authController.signIn(req, res));
authRouter.get("/check-auth", authMiddleware, (req, res) => authController.checkAuth(req, res));

module.exports = authRouter;
