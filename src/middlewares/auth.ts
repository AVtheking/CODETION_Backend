import { NextFunction, Response } from "express";
import jwt, { Secret } from "jsonwebtoken";
import { ErrorHandler } from "./error";

export const auth = async (req: any, res: Response, next: NextFunction) => {
  try {
    let token = req.headers["authorization"];
    if (!token) {
      return new ErrorHandler(401, "No token, authorization denied");
    }
    token = token.replace(/^Bearer\s+/, "");
    jwt.verify(
      token,
      process.env.USER as Secret,
      async (err: any, payload: any) => {
        if (err) {
          return next(new ErrorHandler(401, "Token is not valid"));
        }
        const id = (payload as { id: string }).id;
        req.user = id;
      }
    );
  } catch (err: unknown) {
    next(err);
  }
};
