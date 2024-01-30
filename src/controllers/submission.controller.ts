import { Queue } from "bullmq";
import { NextFunction } from "express";
import { prisma } from "../utils/db";
const redisHost = process.env.REDIS_HOST || "127.0.0.1";
const redisPort: number = 6379;

const submissionQueue = new Queue("submissionQueue", {
  connection: { host: redisHost, port: redisPort },
});
const submissionCtrl = {
  createSubmissiom: async (req: any, res: Response, next: NextFunction) => {
    try {
      const { code, language, input, problemId } = req.body;
      const newSubmission = await prisma.submission.create({
        data: {
          code,
          language,
          input,
          problem: { connect: { id: problemId } },
        },
      });
      await submissionQueue.add("submission", {
        code,
        language,
        input,
        problemId,
      });
    } catch (e: unknown) {
      next(e);
    }
  },
};
