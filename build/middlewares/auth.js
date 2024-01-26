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
exports.auth = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const error_1 = require("./error");
const auth = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        let token = req.headers["authorization"];
        if (!token) {
            return new error_1.ErrorHandler(401, "No token, authorization denied");
        }
        token = token.replace(/^Bearer\s+/, "");
        jsonwebtoken_1.default.verify(token, process.env.USER, (err, payload) => __awaiter(void 0, void 0, void 0, function* () {
            if (err) {
                return next(new error_1.ErrorHandler(401, "Token is not valid"));
            }
            console.log(payload);
            const id = payload.user_id;
            req.user = id;
            next();
        }));
    }
    catch (err) {
        next(err);
    }
});
exports.auth = auth;
