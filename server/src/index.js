require('dotenv').config();


console.log("JWT_SECRET:", process.env.JWT_SECRET);

const express = require("express");
const mongoose = require("./infrastructure/database/mongoose");
const cors = require("cors");
const authRouter = require("./infrastructure/routes/auth");

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());
app.use(cors()); 
app.use("/api", authRouter);

app.listen(port, "0.0.0.0", () => {
  console.log(`Server started and running on port ${port}`);
});