begin transaction;

drop table if exists "answers";
create table if not exists "answers" (
    "id"        integer,
    "tag"       text not null,
    "answer"    text not null unique,
    primary key("id" autoincrement)
);

commit;
