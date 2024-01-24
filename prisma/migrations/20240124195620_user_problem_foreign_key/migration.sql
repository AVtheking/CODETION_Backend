/*
  Warnings:

  - You are about to drop the column `author` on the `problems` table. All the data in the column will be lost.
  - Added the required column `authorId` to the `problems` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "problems" DROP COLUMN "author",
ADD COLUMN     "authorId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "problems" ADD CONSTRAINT "problems_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
