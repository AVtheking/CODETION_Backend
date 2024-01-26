"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const express_1 = __importDefault(require("express"));
const error_1 = require("./middlewares/error");
const problem_route_1 = require("./routes/problem.route");
const app = (0, express_1.default)();
const port = 9999;
app.get("/", (req, res) => {
    res.send("Hello World");
});
app.use(express_1.default.json());
app.use(express_1.default.urlencoded({ extended: true }));
app.use("/api", problem_route_1.problemRouter, error_1.errorMiddleware);
app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});
