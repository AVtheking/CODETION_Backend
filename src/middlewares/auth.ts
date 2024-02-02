import { NextFunction, Response } from "express";
import jwt, { Secret } from "jsonwebtoken";
import { prisma } from "../utils/db";
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
        console.log(payload);
        const id = (payload as { user_id: number }).user_id;
        const user = await prisma.user.findUnique({ where: { id } });
        if (!user) {
          return next(new ErrorHandler(404, "User not found"));
        }
        req.user = user;
        next();
      }
    );
  } catch (err: unknown) {
    next(err);
  }
};
