"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.upload = void 0;
const fs_1 = __importDefault(require("fs"));
const multer_1 = __importDefault(require("multer"));
const error_1 = require("./error");
const testCaseDir = "public/testcase";
if (!fs_1.default.existsSync(testCaseDir)) {
    fs_1.default.mkdirSync(testCaseDir);
}
const storage = multer_1.default.diskStorage({
    destination: (req, file, cb) => {
        cb(null, testCaseDir);
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + "-" + "testCase");
    },
});
const fileFilter = (req, file, cb) => {
    if (file.originalname.match(/\.(txt|json)$/)) {
        cb(null, true);
    }
    else {
        return cb(new error_1.ErrorHandler(400, "Only .txt and .json format allowed!"), false);
    }
};
exports.upload = (0, multer_1.default)({
    storage: storage,
    fileFilter: fileFilter,
}).single("testCase");
