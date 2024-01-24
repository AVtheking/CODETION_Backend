import express from 'express';
import { upload } from '../middlewares/multer';

const problemRouter = express.Router();

problemRouter.post('/create-problem',upload)