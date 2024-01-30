import "dotenv/config";
import express from "express";
import { errorMiddleware } from "./middlewares/error";
import { problemRouter } from "./routes/problem.route";

const app = express();
const port = 9999;
app.get("/", (req, res) => {
  res.send("Hello World");
});
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/api", problemRouter, errorMiddleware);
app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
