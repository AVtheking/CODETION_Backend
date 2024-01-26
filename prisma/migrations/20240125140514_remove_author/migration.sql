-- DropForeignKey
ALTER TABLE "problems" DROP CONSTRAINT "problems_authorId_fkey";

-- AlterTable
ALTER TABLE "problems" ALTER COLUMN "authorId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "problems" ADD CONSTRAINT "problems_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
