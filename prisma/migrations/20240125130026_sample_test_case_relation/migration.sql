/*
  Warnings:

  - You are about to drop the column `sampleTestCase` on the `problems` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[sampleProblemId]` on the table `test_cases` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "test_cases" DROP CONSTRAINT "test_cases_problemId_fkey";

-- AlterTable
ALTER TABLE "problems" DROP COLUMN "sampleTestCase";

-- AlterTable
ALTER TABLE "test_cases" ADD COLUMN     "sampleProblemId" INTEGER,
ALTER COLUMN "problemId" DROP NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "test_cases_sampleProblemId_key" ON "test_cases"("sampleProblemId");

-- AddForeignKey
ALTER TABLE "test_cases" ADD CONSTRAINT "test_cases_problemId_fkey" FOREIGN KEY ("problemId") REFERENCES "problems"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "test_cases" ADD CONSTRAINT "test_cases_sampleProblemId_fkey" FOREIGN KEY ("sampleProblemId") REFERENCES "problems"("id") ON DELETE SET NULL ON UPDATE CASCADE;
