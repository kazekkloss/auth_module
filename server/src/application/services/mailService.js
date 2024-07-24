const nodemailer = require("nodemailer");
const { MailError } = require("../../errors/customError");

class MailService {
  constructor() {
    this.transporter = nodemailer.createTransport({
      host: "sandbox.smtp.mailtrap.io",
      port: 2525,
      auth: {
        user: "cce6db6f1eb927",
        pass: "a76efadf7b378a",
      },
    });
  }

  async sendVerifyMail(email, userId) {
    const details = {
      from: "cce6db6f1eb927",
      to: email,
      subject: "DrawTask - confirm email",
      html: `<p>Hi ${email}, please click here to <a href="http://0.0.0.0:3000/api/verify?id=${userId}"> verify </a> your mail</p>`,
    };

    try {
      await this.transporter.sendMail(details);
    } catch (error) {
      throw new MailError("Failed to send verification email");
    }
  }
}

module.exports = MailService;
