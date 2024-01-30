/*
  Warnings:

  - Added the required column `code` to the `submissions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `input` to the `submissions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `language` to the `submissions` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "submissions" ADD COLUMN     "code" TEXT NOT NULL,
ADD COLUMN     "input" TEXT NOT NULL,
ADD COLUMN     "language" TEXT NOT NULL;
