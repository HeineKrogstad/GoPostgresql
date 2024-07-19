-- DROP SCHEMA public  CASCADE;

-- CREATE SCHEMA public AUTHORIZATION pg_database_owner;

CREATE type tp_rubric AS ENUM ('private', 'protected', 'public');

CREATE TABLE "campus" (
  "id_campus" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "tp_campus" VARCHAR(255) NOT NULL,
  "address" VARCHAR(255) NOT NULL
);

CREATE TABLE "category" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(100) NOT NULL
);

CREATE TABLE "classroom" (
  "id_classroom" SERIAL PRIMARY KEY,
  "id_campus" INTEGER NOT NULL,
  "num_class" VARCHAR(255) NOT NULL
);

CREATE INDEX "idx_classroom__id_campus" ON "classroom" ("id_campus");

ALTER TABLE "classroom" ADD CONSTRAINT "fk_classroom__id_campus" FOREIGN KEY ("id_campus") REFERENCES "campus" ("id_campus") ON DELETE CASCADE;

CREATE TABLE "participation" (
  "id" SERIAL PRIMARY KEY,
  "presence_status" SMALLINT NOT NULL
);

CREATE TABLE "participation_channel" (
  "id" SERIAL PRIMARY KEY
);

CREATE TABLE "project" (
  "id_project" SERIAL PRIMARY KEY,
  "id_category" INTEGER NOT NULL,
  "id_parent_project" INTEGER,
  "title" VARCHAR(250) NOT NULL,
  "keywords" VARCHAR(255) NOT NULL,
  "abbreviation" VARCHAR(255) NOT NULL,
  "status" INTEGER,
  "desc_full" TEXT NOT NULL,
  "desc_short" TEXT NOT NULL,
  "category" TEXT NOT NULL,
  "href_avatar" VARCHAR(100) NOT NULL,
  "is_favorites" BOOLEAN,
  "owner" BOOLEAN,
  "name_rev" TEXT NOT NULL,
  "dt_start" DATE,
  "dt_end" DATE,
  "last_changed" TIMESTAMP,
  "last_changed_author" TEXT NOT NULL,
  "actions" VARCHAR(255) NOT NULL,
  "tag" JSONB NOT NULL,
  "typeparent" INTEGER,
  "onyarmarka" BOOLEAN,
  "goal" TEXT NOT NULL,
  "params" JSONB NOT NULL
);

CREATE INDEX "idx_project__id_category" ON "project" ("id_category");

CREATE INDEX "idx_project__id_parent_project" ON "project" ("id_parent_project");

ALTER TABLE "project" ADD CONSTRAINT "fk_project__id_category" FOREIGN KEY ("id_category") REFERENCES "category" ("id") ON DELETE CASCADE;

ALTER TABLE "project" ADD CONSTRAINT "fk_project__id_parent_project" FOREIGN KEY ("id_parent_project") REFERENCES "project" ("id_project") ON DELETE SET NULL;

CREATE TABLE "channel" (
  "id_channel" SERIAL PRIMARY KEY,
  "channel_name" TEXT NOT NULL,
  "id_project" INTEGER
);

CREATE INDEX "idx_channel__id_project" ON "channel" ("id_project");

ALTER TABLE "channel" ADD CONSTRAINT "fk_channel__id_project" FOREIGN KEY ("id_project") REFERENCES "project" ("id_project") ON DELETE SET NULL;

CREATE TABLE "channel_participation_channel" (
  "channel" SMALLINT NOT NULL,
  "participation_channel" INTEGER NOT NULL,
  PRIMARY KEY ("channel", "participation_channel")
);

CREATE INDEX "idx_channel_participation_channel" ON "channel_participation_channel" ("participation_channel");

ALTER TABLE "channel_participation_channel" ADD CONSTRAINT "fk_channel_participation_channel__channel" FOREIGN KEY ("channel") REFERENCES "channel" ("id_channel");

ALTER TABLE "channel_participation_channel" ADD CONSTRAINT "fk_channel_participation_channel__participation_channel" FOREIGN KEY ("participation_channel") REFERENCES "participation_channel" ("id");

CREATE TABLE "chat_room" (
  "id_room" SERIAL PRIMARY KEY,
  "room_name" TEXT NOT NULL,
  "id_channel" SMALLINT NOT NULL
);

CREATE INDEX "idx_chat_room__id_channel" ON "chat_room" ("id_channel");

ALTER TABLE "chat_room" ADD CONSTRAINT "fk_chat_room__id_channel" FOREIGN KEY ("id_channel") REFERENCES "channel" ("id_channel") ON DELETE CASCADE;

CREATE TABLE "role" (
  "id_role" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "describe" VARCHAR(255) NOT NULL,
  "permission" JSONB NOT NULL
);

CREATE TABLE "tp_activity" (
  "id_activity" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "color" TEXT UNIQUE NOT NULL
);

CREATE TABLE "tp_attachments" (
  "id_tp_attachment" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "code" INTEGER
);

CREATE TABLE "tp_node" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL
);

CREATE TABLE "node" (
  "id_node" SERIAL PRIMARY KEY,
  "id_tp_node" INTEGER NOT NULL,
  "id_parent_node" INTEGER,
  "name" VARCHAR(255) NOT NULL,
  "dt_create" TIMESTAMP
);

CREATE INDEX "idx_node__id_parent_node" ON "node" ("id_parent_node");

CREATE INDEX "idx_node__id_tp_node" ON "node" ("id_tp_node");

ALTER TABLE "node" ADD CONSTRAINT "fk_node__id_parent_node" FOREIGN KEY ("id_parent_node") REFERENCES "node" ("id_node") ON DELETE SET NULL;

ALTER TABLE "node" ADD CONSTRAINT "fk_node__id_tp_node" FOREIGN KEY ("id_tp_node") REFERENCES "tp_node" ("id");

CREATE TABLE "user_profile" (
  "id_user_profile" SERIAL PRIMARY KEY,
  "login" VARCHAR(12) UNIQUE,
  "password" VARCHAR(24) NOT NULL,
  "refresh_token" VARCHAR(100) NOT NULL,
  "access_token" VARCHAR(100) NOT NULL,
  "dt_reg" TIMESTAMP,
  "name" VARCHAR(100) NOT NULL,
  "suname" VARCHAR(100) NOT NULL,
  "patronymic" TEXT NOT NULL,
  "dt_birth" DATE,
  "email" VARCHAR(250) NOT NULL,
  "phone" TEXT NOT NULL,
  "sn_links" JSONB NOT NULL,
  "href_avatar" VARCHAR(100) NOT NULL,
  "is_active" BOOLEAN,
  "is_staff" BOOLEAN,
  "skill" JSONB NOT NULL
);

CREATE TABLE "activity" (
  "id_activity" SERIAL PRIMARY KEY,
  "id_tp_activity" INTEGER NOT NULL,
  "id_project" INTEGER,
  "name" VARCHAR(255) NOT NULL,
  "describe" TEXT NOT NULL,
  "id_organizer" INTEGER NOT NULL,
  "channel" SMALLINT
);

CREATE INDEX "idx_activity__channel" ON "activity" ("channel");

CREATE INDEX "idx_activity__id_organizer" ON "activity" ("id_organizer");

CREATE INDEX "idx_activity__id_project" ON "activity" ("id_project");

CREATE INDEX "idx_activity__id_tp_activity" ON "activity" ("id_tp_activity");

ALTER TABLE "activity" ADD CONSTRAINT "fk_activity__channel" FOREIGN KEY ("channel") REFERENCES "channel" ("id_channel") ON DELETE SET NULL;

ALTER TABLE "activity" ADD CONSTRAINT "fk_activity__id_organizer" FOREIGN KEY ("id_organizer") REFERENCES "user_profile" ("id_user_profile") ON DELETE CASCADE;

ALTER TABLE "activity" ADD CONSTRAINT "fk_activity__id_project" FOREIGN KEY ("id_project") REFERENCES "project" ("id_project") ON DELETE SET NULL;

ALTER TABLE "activity" ADD CONSTRAINT "fk_activity__id_tp_activity" FOREIGN KEY ("id_tp_activity") REFERENCES "tp_activity" ("id_activity") ON DELETE CASCADE;

CREATE TABLE "draft" (
  "id_draft" UUID PRIMARY KEY,
  "id_node" INTEGER NOT NULL,
  "id_project" INTEGER NOT NULL,
  "id_user_profile" INTEGER,
  "jcontent" JSONB NOT NULL,
  "hcontent" TEXT NOT NULL,
  "rubric" TP_RUBRIC NOT NULL,
  "dt_create" TIMESTAMP
);

CREATE INDEX "idx_draft__id_node" ON "draft" ("id_node");

CREATE INDEX "idx_draft__id_project" ON "draft" ("id_project");

CREATE INDEX "idx_draft__id_user_profile" ON "draft" ("id_user_profile");

ALTER TABLE "draft" ADD CONSTRAINT "fk_draft__id_node" FOREIGN KEY ("id_node") REFERENCES "node" ("id_node") ON DELETE CASCADE;

ALTER TABLE "draft" ADD CONSTRAINT "fk_draft__id_project" FOREIGN KEY ("id_project") REFERENCES "project" ("id_project") ON DELETE CASCADE;

ALTER TABLE "draft" ADD CONSTRAINT "fk_draft__id_user_profile" FOREIGN KEY ("id_user_profile") REFERENCES "user_profile" ("id_user_profile") ON DELETE SET NULL;

CREATE TABLE "attachment" (
  "id_attachment" SERIAL PRIMARY KEY,
  "id_draft" UUID NOT NULL,
  "id_tp_attachment" INTEGER NOT NULL,
  "amount" INTEGER
);

CREATE INDEX "idx_attachment__id_draft" ON "attachment" ("id_draft");

CREATE INDEX "idx_attachment__id_tp_attachment" ON "attachment" ("id_tp_attachment");

ALTER TABLE "attachment" ADD CONSTRAINT "fk_attachment__id_draft" FOREIGN KEY ("id_draft") REFERENCES "draft" ("id_draft") ON DELETE CASCADE;

ALTER TABLE "attachment" ADD CONSTRAINT "fk_attachment__id_tp_attachment" FOREIGN KEY ("id_tp_attachment") REFERENCES "tp_attachments" ("id_tp_attachment") ON DELETE CASCADE;

CREATE TABLE "education" (
  "id_education" SERIAL PRIMARY KEY,
  "id_profile" INTEGER NOT NULL,
  "university" VARCHAR(100) NOT NULL,
  "subdivision" VARCHAR(100) NOT NULL,
  "department" VARCHAR(100) NOT NULL,
  "begin_year" INTEGER,
  "end_year" INTEGER,
  "level" VARCHAR(100) NOT NULL
);

CREATE INDEX "idx_education__id_profile" ON "education" ("id_profile");

ALTER TABLE "education" ADD CONSTRAINT "fk_education__id_profile" FOREIGN KEY ("id_profile") REFERENCES "user_profile" ("id_user_profile") ON DELETE CASCADE;

CREATE TABLE "member_in_project" (
  "id" SERIAL PRIMARY KEY,
  "id_project" INTEGER NOT NULL,
  "id_user_profile" INTEGER NOT NULL,
  "is_owner" BOOLEAN,
  "is_favorite" BOOLEAN
);

CREATE INDEX "idx_member_in_project__id_project" ON "member_in_project" ("id_project");

CREATE INDEX "idx_member_in_project__id_user_profile" ON "member_in_project" ("id_user_profile");

ALTER TABLE "member_in_project" ADD CONSTRAINT "fk_member_in_project__id_project" FOREIGN KEY ("id_project") REFERENCES "project" ("id_project") ON DELETE CASCADE;

ALTER TABLE "member_in_project" ADD CONSTRAINT "fk_member_in_project__id_user_profile" FOREIGN KEY ("id_user_profile") REFERENCES "user_profile" ("id_user_profile") ON DELETE CASCADE;

CREATE TABLE "participation_channel_user_profile" (
  "participation_channel" INTEGER NOT NULL,
  "user_profile" INTEGER NOT NULL,
  PRIMARY KEY ("participation_channel", "user_profile")
);

CREATE INDEX "idx_participation_channel_user_profile" ON "participation_channel_user_profile" ("user_profile");

ALTER TABLE "participation_channel_user_profile" ADD CONSTRAINT "fk_participation_channel_user_profile__participation_channel" FOREIGN KEY ("participation_channel") REFERENCES "participation_channel" ("id");

ALTER TABLE "participation_channel_user_profile" ADD CONSTRAINT "fk_participation_channel_user_profile__user_profile" FOREIGN KEY ("user_profile") REFERENCES "user_profile" ("id_user_profile");

CREATE TABLE "мember" (
  "id_member" INTEGER PRIMARY KEY,
  "id_user_profile" INTEGER NOT NULL,
  "id_role" INTEGER NOT NULL
);

CREATE INDEX "idx_мember__id_role" ON "мember" ("id_role");

CREATE INDEX "idx_мember__id_user_profile" ON "мember" ("id_user_profile");

ALTER TABLE "мember" ADD CONSTRAINT "fk_мember__id_role" FOREIGN KEY ("id_role") REFERENCES "role" ("id_role") ON DELETE CASCADE;

ALTER TABLE "мember" ADD CONSTRAINT "fk_мember__id_user_profile" FOREIGN KEY ("id_user_profile") REFERENCES "user_profile" ("id_user_profile") ON DELETE CASCADE;

CREATE TABLE "participation_member" (
  "id_participation" INTEGER NOT NULL,
  "id_members" INTEGER NOT NULL,
  PRIMARY KEY ("id_participation", "id_members")
);

CREATE INDEX "idx_participation_member__id_members" ON "participation_member" ("id_members");

ALTER TABLE "participation_member" ADD CONSTRAINT "fk_participation_member__id_members" FOREIGN KEY ("id_members") REFERENCES "мember" ("id_member") ON DELETE CASCADE;

ALTER TABLE "participation_member" ADD CONSTRAINT "fk_participation_member__id_participation" FOREIGN KEY ("id_participation") REFERENCES "participation" ("id") ON DELETE CASCADE;

CREATE TABLE "timetable" (
  "id_timetable" SERIAL PRIMARY KEY,
  "id_activity" INTEGER NOT NULL,
  "tm_start" TIMESTAMP,
  "tm_end" TIMESTAMP,
  "id_member" INTEGER NOT NULL,
  "id_classroom" INTEGER NOT NULL
);

CREATE INDEX "idx_timetable__id_activity" ON "timetable" ("id_activity");

CREATE INDEX "idx_timetable__id_classroom" ON "timetable" ("id_classroom");

CREATE INDEX "idx_timetable__id_member" ON "timetable" ("id_member");

ALTER TABLE "timetable" ADD CONSTRAINT "fk_timetable__id_activity" FOREIGN KEY ("id_activity") REFERENCES "activity" ("id_activity") ON DELETE CASCADE;

ALTER TABLE "timetable" ADD CONSTRAINT "fk_timetable__id_classroom" FOREIGN KEY ("id_classroom") REFERENCES "classroom" ("id_classroom") ON DELETE CASCADE;

ALTER TABLE "timetable" ADD CONSTRAINT "fk_timetable__id_member" FOREIGN KEY ("id_member") REFERENCES "мember" ("id_member") ON DELETE CASCADE;

CREATE TABLE "timetable_participation" (
  "id_participation" INTEGER NOT NULL,
  "id_timetables" INTEGER NOT NULL,
  PRIMARY KEY ("id_participation", "id_timetables")
);

CREATE INDEX "idx_timetable_participation__id_timetables" ON "timetable_participation" ("id_timetables");

ALTER TABLE "timetable_participation" ADD CONSTRAINT "fk_timetable_participation__id_participation" FOREIGN KEY ("id_participation") REFERENCES "participation" ("id") ON DELETE CASCADE;

ALTER TABLE "timetable_participation" ADD CONSTRAINT "fk_timetable_participation__id_timetables" FOREIGN KEY ("id_timetables") REFERENCES "timetable" ("id_timetable") ON DELETE CASCADE