/*
  Warnings:

  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "problems" DROP CONSTRAINT "problems_authorId_fkey";

-- DropForeignKey
ALTER TABLE "submissions" DROP CONSTRAINT "submissions_userId_fkey";

-- AlterTable
ALTER TABLE "problems" ALTER COLUMN "authorId" SET DATA TYPE BIGINT;

-- AlterTable
ALTER TABLE "submissions" ALTER COLUMN "userId" SET DATA TYPE BIGINT;

-- DropTable
DROP TABLE "users";

-- CreateTable
CREATE TABLE "auth_group" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(150) NOT NULL,

    CONSTRAINT "auth_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth_group_permissions" (
    "id" BIGSERIAL NOT NULL,
    "group_id" INTEGER NOT NULL,
    "permission_id" INTEGER NOT NULL,

    CONSTRAINT "auth_group_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth_permission" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "content_type_id" INTEGER NOT NULL,
    "codename" VARCHAR(100) NOT NULL,

    CONSTRAINT "auth_permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "authentication_forgetpassword" (
    "id" BIGSERIAL NOT NULL,
    "email" VARCHAR(255),
    "token" VARCHAR(50),
    "created_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "authentication_forgetpassword_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "authentication_onetimepassword" (
    "id" BIGSERIAL NOT NULL,
    "email" VARCHAR(255),
    "otp" VARCHAR(6) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "authentication_onetimepassword_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "authentication_user" (
    "password" VARCHAR(128) NOT NULL,
    "id" BIGSERIAL NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "username" VARCHAR(100),
    "is_superuser" BOOLEAN NOT NULL,
    "is_verified" BOOLEAN NOT NULL,
    "date_joined" TIMESTAMPTZ(6) NOT NULL,
    "last_login" TIMESTAMPTZ(6) NOT NULL,
    "auth_provider" VARCHAR(50) NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "is_staff" BOOLEAN NOT NULL,

    CONSTRAINT "authentication_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "authentication_user_groups" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "group_id" INTEGER NOT NULL,

    CONSTRAINT "authentication_user_groups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "authentication_user_user_permissions" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "permission_id" INTEGER NOT NULL,

    CONSTRAINT "authentication_user_user_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "django_admin_log" (
    "id" SERIAL NOT NULL,
    "action_time" TIMESTAMPTZ(6) NOT NULL,
    "object_id" TEXT,
    "object_repr" VARCHAR(200) NOT NULL,
    "action_flag" SMALLINT NOT NULL,
    "change_message" TEXT NOT NULL,
    "content_type_id" INTEGER,
    "user_id" BIGINT NOT NULL,

    CONSTRAINT "django_admin_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "django_content_type" (
    "id" SERIAL NOT NULL,
    "app_label" VARCHAR(100) NOT NULL,
    "model" VARCHAR(100) NOT NULL,

    CONSTRAINT "django_content_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "django_migrations" (
    "id" BIGSERIAL NOT NULL,
    "app" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "applied" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "django_migrations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "django_session" (
    "session_key" VARCHAR(40) NOT NULL,
    "session_data" TEXT NOT NULL,
    "expire_date" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "django_session_pkey" PRIMARY KEY ("session_key")
);

-- CreateTable
CREATE TABLE "quiz_choice" (
    "id" BIGSERIAL NOT NULL,
    "choice_text" VARCHAR(200) NOT NULL,
    "is_correct" BOOLEAN NOT NULL,
    "question_id" BIGINT NOT NULL,

    CONSTRAINT "quiz_choice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "quiz_question" (
    "id" BIGSERIAL NOT NULL,
    "title" VARCHAR(200) NOT NULL,
    "description" TEXT NOT NULL,
    "quiz_id" BIGINT NOT NULL,

    CONSTRAINT "quiz_question_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "quiz_quiz" (
    "id" BIGSERIAL NOT NULL,
    "title" VARCHAR(200) NOT NULL,
    "start_time" TIMESTAMPTZ(6) NOT NULL,
    "end_time" TIMESTAMPTZ(6) NOT NULL,
    "description" TEXT NOT NULL,
    "admin_id" BIGINT NOT NULL,

    CONSTRAINT "quiz_quiz_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "quiz_registeredparticipant" (
    "id" BIGSERIAL NOT NULL,
    "quiz_id" BIGINT NOT NULL,
    "quizinee_id" BIGINT NOT NULL,
    "score" INTEGER NOT NULL,

    CONSTRAINT "quiz_registeredparticipant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "quiz_submission" (
    "id" BIGSERIAL NOT NULL,
    "quizinee_id" BIGINT,
    "selected_choice_id" BIGINT,
    "question_id" BIGINT,

    CONSTRAINT "quiz_submission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "token_blacklist_blacklistedtoken" (
    "id" BIGSERIAL NOT NULL,
    "blacklisted_at" TIMESTAMPTZ(6) NOT NULL,
    "token_id" BIGINT NOT NULL,

    CONSTRAINT "token_blacklist_blacklistedtoken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "token_blacklist_outstandingtoken" (
    "id" BIGSERIAL NOT NULL,
    "token" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6),
    "expires_at" TIMESTAMPTZ(6) NOT NULL,
    "user_id" BIGINT,
    "jti" VARCHAR(255) NOT NULL,

    CONSTRAINT "token_blacklist_outstandingtoken_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "auth_group_name_key" ON "auth_group"("name");

-- CreateIndex
CREATE INDEX "auth_group_name_a6ea08ec_like" ON "auth_group"("name");

-- CreateIndex
CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions"("group_id");

-- CreateIndex
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions"("permission_id");

-- CreateIndex
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions"("group_id", "permission_id");

-- CreateIndex
CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "auth_permission"("content_type_id");

-- CreateIndex
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission"("content_type_id", "codename");

-- CreateIndex
CREATE UNIQUE INDEX "authentication_onetimepassword_email_key" ON "authentication_onetimepassword"("email");

-- CreateIndex
CREATE INDEX "authentication_onetimepassword_email_cfe9c50b_like" ON "authentication_onetimepassword"("email");

-- CreateIndex
CREATE UNIQUE INDEX "authentication_user_email_key" ON "authentication_user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "authentication_user_username_key" ON "authentication_user"("username");

-- CreateIndex
CREATE INDEX "authentication_user_email_2220eff5_like" ON "authentication_user"("email");

-- CreateIndex
CREATE INDEX "authentication_user_username_a09a089e_like" ON "authentication_user"("username");

-- CreateIndex
CREATE INDEX "authentication_user_groups_group_id_6b5c44b7" ON "authentication_user_groups"("group_id");

-- CreateIndex
CREATE INDEX "authentication_user_groups_user_id_30868577" ON "authentication_user_groups"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "authentication_user_groups_user_id_group_id_8af031ac_uniq" ON "authentication_user_groups"("user_id", "group_id");

-- CreateIndex
CREATE INDEX "authentication_user_user_permissions_permission_id_ea6be19a" ON "authentication_user_user_permissions"("permission_id");

-- CreateIndex
CREATE INDEX "authentication_user_user_permissions_user_id_736ebf7e" ON "authentication_user_user_permissions"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "authentication_user_user_user_id_permission_id_ec51b09f_uniq" ON "authentication_user_user_permissions"("user_id", "permission_id");

-- CreateIndex
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log"("content_type_id");

-- CreateIndex
CREATE INDEX "django_admin_log_user_id_c564eba6" ON "django_admin_log"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type"("app_label", "model");

-- CreateIndex
CREATE INDEX "django_session_expire_date_a5c62663" ON "django_session"("expire_date");

-- CreateIndex
CREATE INDEX "django_session_session_key_c0390e0f_like" ON "django_session"("session_key");

-- CreateIndex
CREATE INDEX "quiz_choice_question_id_6297ad3f" ON "quiz_choice"("question_id");

-- CreateIndex
CREATE INDEX "quiz_question_quiz_id_b7429966" ON "quiz_question"("quiz_id");

-- CreateIndex
CREATE UNIQUE INDEX "quiz_quiz_title_eebababc_uniq" ON "quiz_quiz"("title");

-- CreateIndex
CREATE INDEX "quiz_quiz_admin_id_c4779dff" ON "quiz_quiz"("admin_id");

-- CreateIndex
CREATE INDEX "quiz_quiz_title_eebababc_like" ON "quiz_quiz"("title");

-- CreateIndex
CREATE INDEX "quiz_registeredparticipant_quiz_id_e7d5ffad" ON "quiz_registeredparticipant"("quiz_id");

-- CreateIndex
CREATE INDEX "quiz_registeredparticipant_quizinee_id_9c017a58" ON "quiz_registeredparticipant"("quizinee_id");

-- CreateIndex
CREATE INDEX "quiz_submission_question_id_9d0b4bdb" ON "quiz_submission"("question_id");

-- CreateIndex
CREATE INDEX "quiz_submission_quizinee_id_d30ba86d" ON "quiz_submission"("quizinee_id");

-- CreateIndex
CREATE INDEX "quiz_submission_selected_choice_id_d2e182a1" ON "quiz_submission"("selected_choice_id");

-- CreateIndex
CREATE UNIQUE INDEX "token_blacklist_blacklistedtoken_token_id_key" ON "token_blacklist_blacklistedtoken"("token_id");

-- CreateIndex
CREATE UNIQUE INDEX "token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq" ON "token_blacklist_outstandingtoken"("jti");

-- CreateIndex
CREATE INDEX "token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like" ON "token_blacklist_outstandingtoken"("jti");

-- CreateIndex
CREATE INDEX "token_blacklist_outstandingtoken_user_id_83bc629a" ON "token_blacklist_outstandingtoken"("user_id");

-- AddForeignKey
ALTER TABLE "problems" ADD CONSTRAINT "problems_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "authentication_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "submissions" ADD CONSTRAINT "submissions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "authentication_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "auth_group_permissions" ADD CONSTRAINT "auth_group_permissio_permission_id_84c5c92e_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "auth_permission"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth_group_permissions" ADD CONSTRAINT "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "auth_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth_permission" ADD CONSTRAINT "auth_permission_content_type_id_2f476e4b_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "authentication_user_groups" ADD CONSTRAINT "authentication_user__user_id_30868577_fk_authentic" FOREIGN KEY ("user_id") REFERENCES "authentication_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "authentication_user_groups" ADD CONSTRAINT "authentication_user_groups_group_id_6b5c44b7_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "auth_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "authentication_user_user_permissions" ADD CONSTRAINT "authentication_user__permission_id_ea6be19a_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "auth_permission"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "authentication_user_user_permissions" ADD CONSTRAINT "authentication_user__user_id_736ebf7e_fk_authentic" FOREIGN KEY ("user_id") REFERENCES "authentication_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "django_admin_log" ADD CONSTRAINT "django_admin_log_content_type_id_c4bce8eb_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "django_admin_log" ADD CONSTRAINT "django_admin_log_user_id_c564eba6_fk_authentication_user_id" FOREIGN KEY ("user_id") REFERENCES "authentication_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "quiz_choice" ADD CONSTRAINT "quiz_choice_question_id_6297ad3f_fk_quiz_question_id" FOREIGN KEY ("question_id") REFERENCES "quiz_question"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "quiz_question" ADD CONSTRAINT "quiz_question_quiz_id_b7429966_fk_quiz_quiz_id" FOREIGN KEY ("quiz_id") REFERENCES "quiz_quiz"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "quiz_quiz" ADD CONSTRAINT "quiz_quiz_admin_id_c4779dff_fk_authentication_user_id" FOREIGN KEY ("admin_id") REFERENCES "authentication_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "quiz_registeredparticipant" ADD CONSTRAINT "quiz_registeredparti_quizinee_id_9c017a58_fk_authentic" FOREIGN KEY ("quizinee_id") REFERENCES "authentication_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "quiz_registeredparticipant" ADD CONSTRAINT "quiz_registeredparticipant_quiz_id_e7d5ffad_fk_quiz_quiz_id" FOREIGN KEY ("quiz_id") REFERENCES "quiz_quiz"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "quiz_submission" ADD CONSTRAINT "quiz_submission_question_id_9d0b4bdb_fk_quiz_question_id" FOREIGN KEY ("question_id") REFERENCES "quiz_question"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "quiz_submission" ADD CONSTRAINT "quiz_submission_quizinee_id_d30ba86d_fk_authentication_user_id" FOREIGN KEY ("quizinee_id") REFERENCES "authentication_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "quiz_submission" ADD CONSTRAINT "quiz_submission_selected_choice_id_d2e182a1_fk_quiz_choice_id" FOREIGN KEY ("selected_choice_id") REFERENCES "quiz_choice"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "token_blacklist_blacklistedtoken" ADD CONSTRAINT "token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk" FOREIGN KEY ("token_id") REFERENCES "token_blacklist_outstandingtoken"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "token_blacklist_outstandingtoken" ADD CONSTRAINT "token_blacklist_outs_user_id_83bc629a_fk_authentic" FOREIGN KEY ("user_id") REFERENCES "authentication_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
