import express from "express";
import { problemController } from "../controllers/problem.controller";
import { auth } from "../middlewares/auth";
import { upload } from "../middlewares/multer";

export const problemRouter = express.Router();

problemRouter.post("/problem", auth, upload, problemController.createProblem);
problemRouter.get("/problems", auth, problemController.getAllProblems);
problemRouter.put("/problem", auth, problemController.updateProblem);
