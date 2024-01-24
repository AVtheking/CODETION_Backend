import fs from "fs";
import { TestCaseInput } from "../types/types";
import { prisma } from "../utils/db";

export const problemController = {
  createProblem: async (req: any, res: any, next: any) => {
    try {
      const userId = req.user;
      const { title, description, difficulty, sampleTestCase, time, memory } =
        req.body;
      const testCaseFilePath = req.file.path;
      const testCases: TestCaseInput[] = parseTestCases(
        fs.readFileSync(testCaseFilePath, "utf-8")
      );

      const problem = await prisma.problem.create({
        data: {
          title,
          description,
          difficulty,
          sampleTestCase,
          time,
          memory,
          author: {
            connect: {
              id: userId,
            },
          },

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
      return res.status(201).json(problem);
    } catch (err: unknown) {
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
      return res.json(problems);
    } catch (err: unknown) {
      next(err);
    }
  },
  updateProblem: async (req: any, res: any, next: any) => {
    try {
      const userId = req.user;
      const { title, description, difficulty, sampleTestCase, time, memory } =
        req.body;
      const updatedProblem = await prisma.problem.update({
        where: {
          id: userId,
        },
        data: {
          title,
          description,
          difficulty,
          sampleTestCase,
          time,
          memory,
        },
        include: {
          testCases: true,
        },
      });
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
    return testCaseInputs;
  } catch (error: unknown) {
    console.log("Error parsing test cases");
    return [];
  }
}
