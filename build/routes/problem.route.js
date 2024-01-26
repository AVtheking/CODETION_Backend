"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.problemRouter = void 0;
const express_1 = __importDefault(require("express"));
const problem_controller_1 = require("../controllers/problem.controller");
const auth_1 = require("../middlewares/auth");
const multer_1 = require("../middlewares/multer");
exports.problemRouter = express_1.default.Router();
exports.problemRouter.post("/problem", auth_1.auth, multer_1.upload, problem_controller_1.problemController.createProblem);
exports.problemRouter.get("/problems", auth_1.auth, problem_controller_1.problemController.getAllProblems);
exports.problemRouter.put("/problem", auth_1.auth, problem_controller_1.problemController.updateProblem);
