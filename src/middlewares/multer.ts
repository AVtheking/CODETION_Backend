import fs from "fs";
import multer from "multer";
import { ErrorHandler } from "./error";

const testCaseDir = "public/testcase";
if (!fs.existsSync(testCaseDir)) {
  fs.mkdirSync(testCaseDir);
}
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, testCaseDir);
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + "testCase");
  },
});
const fileFilter = (req: any, file: any, cb: any) => {
  if (file.originalname.match(/\.(txt|json)$/)) {
    cb(null, true);
  } else {
    return cb(
      new ErrorHandler(400, "Only .txt and .json format allowed!"),
      false
    );
  }
};
export const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
}).single("testCase");
