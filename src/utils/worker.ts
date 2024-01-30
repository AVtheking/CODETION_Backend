import { ConnectionOptions, Job, Worker } from "bullmq";
import { prisma } from "./db";

const connectionOptions: ConnectionOptions = {
  host: process.env.REDIS_HOST || "127.0.0.1",
  port: 6379,
};
const worker = new Worker(
  "submissionQueue",
  async (job: Job) => {
    const { code, language, input, problemId } = job.data;
    console.log(code, language, input, problemId);
    const problems = await prisma.problem.findFirst({
      where: { id: problemId },
      include: { testCases: true },
    });
    const systemTestCases = problems?.testCases;
    const time = problems?.time;
    const memory = problems?.memory;

    // const container=await
  },
  {
    connection: connectionOptions,
    concurrency: 5,
    removeOnComplete: {
      count: 10,
    },
  }
);
