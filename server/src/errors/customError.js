class CustomError extends Error {
    constructor(message) {
      super(message);
      this.name = this.constructor.name;
      Error.captureStackTrace(this, this.constructor);
    }
  
    getStatusCode() {
      if (this instanceof UserAlreadyExistsError) {
        return 409; // Conflict
      }
      if (this instanceof UserNotFoundError) {
        return 404; // Not Found
      }
      if (this instanceof IncorrectPasswordError) {
        return 400; // Bad Request
      }
      if (this instanceof MailError) {
        return 500; // Internal Server Error
      }
      return 500; // Internal Server Error
    }
  }
  
  class UserAlreadyExistsError extends CustomError {}
  class UserNotFoundError extends CustomError {}
  class IncorrectPasswordError extends CustomError {}
  class MailError extends CustomError {}
  
  module.exports = {
    CustomError,
    UserAlreadyExistsError,
    UserNotFoundError,
    IncorrectPasswordError,
    MailError,
  };
  