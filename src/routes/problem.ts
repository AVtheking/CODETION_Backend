import express from "express";
import { problemController } from "../controllers/problem.controller";
import { auth } from "../middlewares/auth";
import { upload } from "../middlewares/multer";

export const problemRouter = express.Router();

problemRouter.post(
  "/create-problem",
  auth,
  upload,
  problemController.createProblem
);
problemRouter.get("/get-all-problems", auth, problemController.getAllProblems);
problemRouter.put("/update-problem", auth, problemController.updateProblem);
