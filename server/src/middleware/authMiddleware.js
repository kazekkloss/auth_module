const jwt = require("jsonwebtoken");

const authMiddleware = (req, res, next) => {
  const token = req.headers["authorization"];
  if (!token) {
    console.log("No token provided");
    return res.status(401).json({ message: "No token provided" });
  }

  const tokenParts = token.split(" ");
  if (tokenParts.length !== 2 || tokenParts[0] !== "Bearer") {
    console.log("Invalid token format");
    return res.status(401).json({ message: "Invalid token format" });
  }

  const authToken = tokenParts[1];

  console.log("Token to verify:", authToken);
  console.log("JWT_SECRET:", process.env.JWT_SECRET);

  jwt.verify(authToken, process.env.JWT_SECRET, (err, decoded) => {
    if (err) {
      console.log("Token verification error:", err.message);
      return res.status(401).json({ message: "Failed to authenticate token" });
    }
    console.log("Token verified successfully:", decoded);
    req.userId = decoded.id;
    next();
  });
};

module.exports = authMiddleware;
