"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.errorMiddleware = exports.ErrorHandler = void 0;
class ErrorHandler extends Error {
    constructor(statusCode, message) {
        super(message);
        this.statusCode = statusCode;
    }
}
exports.ErrorHandler = ErrorHandler;
const errorMiddleware = (err, req, res, next) => {
    err.message = err.message || "Interal Server Error";
    err.statusCode = err.statusCode || 500;
    console.log(err);
    return res.status(err.statusCode).json({
        success: false,
        message: err.message,
    });
};
exports.errorMiddleware = errorMiddleware;
