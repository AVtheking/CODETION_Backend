import fs from "fs";
import { TestCaseInput } from "../types/types";
import { prisma } from "../utils/db";

const problemController = {
  createProblem: async (req: any, res: Response, next: any) => {
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
        authorId: userId,
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
