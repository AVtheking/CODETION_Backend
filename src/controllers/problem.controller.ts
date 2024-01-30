import fs from "fs";
import { TestCaseInput } from "../types/types";
import { prisma } from "../utils/db";
import { problemSchema } from "../utils/validation";

export const problemController = {
  createProblem: async (req: any, res: any, next: any) => {
    try {
      console.log(req.user);
      const userId = req.user;

      const result = await problemSchema.validateAsync(req.body);
      let { title, description, difficulty, sampleTestCase, time, memory } =
        result;

      time = parseInt(time);
      memory = parseInt(memory);
      const testCaseFilePath = req.file.path;

      const sample = JSON.parse(sampleTestCase);

      const testCases: TestCaseInput[] = parseTestCases(
        fs.readFileSync(testCaseFilePath, "utf-8")
      );

      const problem = await prisma.problem.create({
        data: {
          title,
          description,
          difficulty,
          sampleTestCase: {
            create: {
              input: sample.input,
              output: sample.output,
            },
          },
          time,
          memory,
          //   author: {
          //     connect: {
          //       id: userId,
          //     },
          //   },

          testCases: {
            createMany: {
              data: testCases,
            },
          },
        },
        include: {
          testCases: true,
        },
      });
      return res.status(201).json({
        success: true,
        problem,
      });
    } catch (err: unknown) {
      fs.unlinkSync(req.file.path);
      next(err);
    }
  },
  getAllProblems: async (req: any, res: any, next: any) => {
    try {
      const problems = await prisma.problem.findMany({
        include: {
          testCases: true,
        },
      });
      return res.json({
        success: true,
        problems,
      });
    } catch (err: unknown) {
      next(err);
    }
  },
  updateProblem: async (req: any, res: any, next: any) => {
    try {
      const userId = req.user;
      const { title, description, difficulty, sampleTestCase, time, memory } =
        req.body;
      const sample = JSON.parse(sampleTestCase);

      const updatedProblem = await prisma.problem.update({
        where: {
          id: userId,
        },
        data: {
          title,
          description,
          difficulty,
          sampleTestCase: {
            update: {
              input: sample.input,
              output: sample.output,
            },
          },
          time,
          memory,
        },
        include: {
          testCases: true,
        },
      });
      res.json(updatedProblem);
    } catch (err: unknown) {
      next(err);
    }
  },
};
function parseTestCases(fileContent: string): TestCaseInput[] {
  try {
    const testCases: { input: string; output: string }[] =
      JSON.parse(fileContent);
    const testCaseInputs: TestCaseInput[] = testCases.map(
      ({ input, output }) => ({ input, output })
    );
    console.log(testCaseInputs);
    return testCaseInputs;
  } catch (error: unknown) {
    console.log("Error parsing test cases");
    return [];
  }
}
