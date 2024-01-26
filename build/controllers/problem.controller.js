"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.problemController = void 0;
const fs_1 = __importDefault(require("fs"));
const db_1 = require("../utils/db");
exports.problemController = {
    createProblem: (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
        console.log("here");
        try {
            console.log(req.user);
            const userId = req.user;
            let { title, description, difficulty, sampleTestCase, time, memory } = req.body;
            time = parseInt(time);
            memory = parseInt(memory);
            const testCaseFilePath = req.file.path;
            //   console.log(testCaseFilePath);
            const sample = JSON.parse(sampleTestCase);
            const testCases = parseTestCases(fs_1.default.readFileSync(testCaseFilePath, "utf-8"));
            const problem = yield db_1.prisma.problem.create({
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
            return res.status(201).json(problem);
        }
        catch (err) {
            fs_1.default.unlinkSync(req.file.path);
            next(err);
        }
    }),
    getAllProblems: (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            const problems = yield db_1.prisma.problem.findMany({
                include: {
                    testCases: true,
                },
            });
            return res.json(problems);
        }
        catch (err) {
            next(err);
        }
    }),
    updateProblem: (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            const userId = req.user;
            const { title, description, difficulty, sampleTestCase, time, memory } = req.body;
            const updatedProblem = yield db_1.prisma.problem.update({
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
        }
        catch (err) {
            next(err);
        }
    }),
};
function parseTestCases(fileContent) {
    try {
        const testCases = JSON.parse(fileContent);
        const testCaseInputs = testCases.map(({ input, output }) => ({ input, output }));
        console.log(testCaseInputs);
        return testCaseInputs;
    }
    catch (error) {
        console.log("Error parsing test cases");
        return [];
    }
}
