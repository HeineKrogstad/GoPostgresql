
--delete from user_profile;
INSERT INTO user_profile (id_user_profile, login, password, refresh_token, access_token, dt_reg, name, suname, patronymic, dt_birth, email, phone, sn_links, href_avatar, is_active, is_staff, skill) 
     VALUES (1, 'Hector', 'hect', '123', 'Oklahoma', '2097-05-13T22:21:47.223', 'Demetrius', 'Strosin', 'Leslie', '1988-02-13T21:26:46.827', 'Cierra.Parker@hotmail.com', '1-378-283-8315', '{"foo":20083,"bar":83739,"bike":"jzjSMD*<Bb","a":30,"b":85026,"name":24863,"prop":"I{-#A\"y,&$"}', 'https://loremflickr.com/640/480', 'false', 'false', '{"foo":53211,"bar":"6q@Vy*\\n!c","bike":1556,"a":"[ChTshL\\b3","b":"ir[W|;Sya+","name":77664,"prop":"=!qBCMswu"}');
INSERT INTO user_profile (id_user_profile, login, password, refresh_token, access_token, dt_reg, name, suname, patronymic, dt_birth, email, phone, sn_links, href_avatar, is_active, is_staff, skill) 
VALUES (2, 'Julianne', 'juli', '123', 'Kansas', '2018-05-07T17:28:22.548', 'Johathan', 'Vandervort', 'August', '2000-12-13T23:34:31.252', 'Rubie.Batz@yahoo.com', '336.287.4740 x082', '{"foo":64485,"bar":96742,"bike":49716,"a":"vi7jWrN$%W","b":45226,"name":12798,"prop":57372}', 'https://loremflickr.com/640/480', 'false', 'false', '{"foo":"FY6\"9*:J+.","bar":56808,"bike":"17E=ntkB2;","a":20952,"b":55667,"name":10983,"prop":"]l1dq{Erkt"}');
INSERT INTO user_profile (id_user_profile, login, password, refresh_token, access_token, dt_reg, name, suname, patronymic, dt_birth, email, phone, sn_links, href_avatar, is_active, is_staff, skill) 
VALUES (3, 'Augustus', 'aug', '123', 'Arkansas', '2089-12-19T05:22:26.006', 'Bryon', 'OHara', 'James', '1959-12-13T08:40:52.951', 'Minnie_Smitham@yahoo.com', '871-283-0896 x01615', '{"foo":25606,"bar":"7R\"aV\\AECx","bike":"7u;5Y}bvf)","a":83654,"b":67157,"name":29718,"prop":78556}', 'https://loremflickr.com/640/480', 'false', 'true', '{"foo":78576,"bar":"fR][qZvWxR","bike":"U+Rpj7rLh","a":"nqG#/Z8[hm","b":32378,"name":70310,"prop":97934}');

--delete from category;
INSERT INTO category
(id, "name")
VALUES(1, 'Первая категория');
INSERT INTO category
(id, "name")
VALUES(2, 'Вторая категория');

--delete from project;
INSERT INTO project (    id_project,     id_category,     id_parent_project,     title,     keywords,     abbreviation,     status,     desc_full,     desc_short,     category,     href_avatar,     is_favorites,     owner,     name_rev,     dt_start,     dt_end,     last_changed,     last_changed_author,     actions,     tag,     typeParent,     onYarmarka,     goal, params) 
VALUES (1, 1, NULL, 'Car', 'Feil Fall', 'UTF8', '98910', 'International', 'Lead Markets Specialist', '2', 'https://loremflickr.com/640/480/cats', 'false', 'true', '88f9b03ed7ee04ec684a61a0fa7adcbf9b3fadb8', '2013-06-10T15:27:39.862', '1994-02-26T03:46:53.657', '2085-09-20T18:16:47.240', '2014-09-29T06:44:51.954', 'Cambridgeshire', '{"foo":1941,"bar":"LE;$]I&z+?","bike":70814,"a":"*q6|{AZ]Y&","b":"=[dbTQ}\"jX","name":43481,"prop":"EPMGSfYxS`"}', NULL, 'false', 'Repellat labore labore aut architecto nulla aspernatur necessitatibus. Quasi similique saepe voluptatum accusantium.', '{"foo":22674,"bar":4360,"bike":73173,"a":20336,"b":"W_,O=qWm>B","name":87776,"prop":"F\\OC&\"=hLR"}');
INSERT INTO project (    id_project,     id_category,     id_parent_project,     title,     keywords,     abbreviation,     status,     desc_full,     desc_short,     category,     href_avatar,     is_favorites,     owner,     name_rev,     dt_start,     dt_end,     last_changed,     last_changed_author,     actions,     tag,     typeParent,     onYarmarka,     goal, params) 
VALUES (2, 1, NULL, 'Hat', 'Waelchi Well', 'XML', '36947', 'Principal', 'Central Markets Developer', '2', 'https://loremflickr.com/640/480/sports', 'true', 'false', '67f9fd496edb76b2a113b2521f3ca83c2dddb6df', '2034-03-12T21:57:38.690', '2001-04-02T14:52:08.416', '2085-04-02T05:56:04.466', '2085-08-05T00:25:32.198', 'Avon', '{"foo":"X1\\^WC$Y2}","bar":"1Ad)B`(>m4","bike":"thcqS=Ug@[","a":"4S([]}%rq","b":82291,"name":16197,"prop":"mQH$+f9(U#"}', NULL, 'true', 'Perferendis dolore quam error similique mollitia atque.', '{"foo":"4p-0]0q!|x","bar":"OUN#ZI0Fq{","bike":67305,"a":16745,"b":"SH+D>#,+HZ","name":61079,"prop":"1*n<s:Dkb/"}');
INSERT INTO project (    id_project,     id_category,     id_parent_project,     title,     keywords,     abbreviation,     status,     desc_full,     desc_short,     category,     href_avatar,     is_favorites,     owner,     name_rev,     dt_start,     dt_end,     last_changed,     last_changed_author,     actions,     tag,     typeParent,     onYarmarka,     goal, params) 
VALUES (7, 2, NULL, 'Pizza', 'Sabina Ranch', 'API', '90550', 'Product', 'Lead Operations Manager', '2', 'https://loremflickr.com/640/480/fashion', 'false', 'false', 'c629fede0bfd5b9b092b1bfb2665dcae9f20fffc', '2083-03-25T18:21:12.175', '2022-02-10T18:30:08.941', '2005-02-19T01:38:08.715', '2095-10-11T08:56:42.142', 'Cambridgeshire', '{"foo":9192,"bar":30646,"bike":3649,"a":59160,"b":"B$>%^-ozXh","name":14626,"prop":8955}', NULL, 'true', 'Rem fugiat tempora culpa alias esse molestias cumque ullam ut. Quod voluptate libero in neque. Perspiciatis reiciendis quisquam fuga maxime labore. Sed commodi quo sit ullam dignissimos quibusdam facilis iure. Vero quia veniam reiciendis blanditiis hic. Sit laborum eum tempore amet cumque.', '{"foo":"+>ntaD>Zg.","bar":"!JWr6m#reC","bike":"G+c_Q;}{_i","a":9415,"b":"^jXEc<pB6I","name":"p!mmbNfE]6","prop":"w,%$nczllD"}');

--delete from tp_node;
INSERT INTO tp_node(id, "name")
	 VALUES(1, 'Тупик'), (2, 'Идея'), (3, 'Успешное завершение') ;
INSERT INTO node(id_node, id_tp_node , "name")
VALUES(1, 2, 'Узел START'), (2, 3, 'Узел FINISH');

--delete from draft;
INSERT INTO draft (id_draft, id_project, id_user_profile, jcontent, rubric, dt_create, id_node) 
VALUES ('b89d3b5c-ef05-42d1-b169-fe6099098f95', '2', '2', '[{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","marks":[{"type":"textStyle","attrs":{"fontFamily":null,"color":"#5b21b6"}}],"text":"10.07.24"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Вот что то такое сделал ? Практические примеры и проекты на Go"}]}]', 'public', '2028-02-06T23:59:31.818', 1);
INSERT INTO draft (id_draft, id_project, id_user_profile, jcontent, rubric, dt_create, id_node) 
VALUES ('de3fc379-f932-4629-b0ec-1fe33b29839c', '1', '3', '[{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","marks":[{"type":"textStyle","attrs":{"fontFamily":null,"color":"#5b21b6"}}],"text":"10.07.24"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Вот что то такое сделал ? Работа с модулями (Go Modules)"}]}]' , 'private', '2060-07-07T15:09:24.322', 2);
INSERT INTO draft (id_draft, id_project, id_user_profile, jcontent, rubric, dt_create, id_node) 
VALUES ('c17e8010-3f02-424a-b985-7bb6d933d289', '2', '2', '[{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","marks":[{"type":"textStyle","attrs":{"fontFamily":null,"color":"#5b21b6"}}],"text":"10.07.24"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Вот что то такое сделал ? Написание многопоточных приложений GO"}]}]', 'protected', '2083-12-21T20:30:17.177', 1);

