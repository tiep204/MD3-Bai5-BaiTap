use test2;
create table students(
studentid int(4) primary key auto_increment,
studentname nvarchar(50) not null,
age int(4) not null,
email nvarchar(100) not null
);
create table classes (
classId int(4) primary key auto_increment ,
classname varchar(50)
);
create table classstudent(
studentid int(4) not null,
classId int(4) not null,
foreign key(studentid) references students (studentid),
foreign key(classId) references classes (classId)
);
create table subjects  (
subjectID int(4) primary key auto_increment,
subjectname varchar(50) not null
);
create table mark(
mark int,
subjectID int(4) not null,
studentid int(4) not null,
foreign key(studentid) references students (studentid),
foreign key(subjectID) references subjects (subjectID)
);

insert into students(studentname, age,email)values
('Nguyen Cong Vinh ',20, 'an@yahoo.com'),
('Nguyen Van Quyen',19, 'vinh@yahoo.com'),
('Pham Thanh Binh',25, '19 quyen'),
('Nguyen Van TaiEm',30, 'taiem@sport.vn');
insert into classes(ClassName)values('C0706L'),('C0708G' );
insert into classstudent(studentid,classId)values(1,1),(2,1),(3,2),(4,2),(5,2);
insert into subjects(subjectname)values ('SQL'),('java'),('c'),('Visual Basic');
insert into mark()values
(8,1,1),(4 ,2, 1),(9 ,1, 1 ),(7 ,1, 3 ),(3 ,1, 4),(5 ,2, 5 ),(8 ,3, 3 ),(1 ,3, 5 ),(3 ,2, 4);
-- 1. Hien thi danh sach tat ca cac hoc vien 
select*from students;
-- 2. Hien thi danh sach tat ca cac mon hoc 
select*from subjects;
-- 3. Tinh diem trung binh
select st.studentid, st.studentname, avg(mark) as avgMArk
from students st inner join mark m on st.studentid=m.studentid
group by st.studentid, st.studentname;
-- 4. Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat

select sb.subjectid, sb.subjectname, max(mark) as maxMark
from mark m inner join subjects sb on m.subjectid= sb.subjectid
group by m.subjectid
having max(mark)>=all(select max(mark) from mark group by subjectid );
-- 5. Danh so thu tu cua diem theo chieu giam;
select *from mark 
order by mark DESC;
-- 6. Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
alter table Subjects
MODIFY subjectname Nvarchar(255) ;

-- 7. Cap nhat them dong chu « Day la mon hoc « vao truoc cac ban ghi tren cot SubjectName trong bang Subjects 

-- 8. Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
alter table students
modify Age int(4) not null check(age between 15 and 50)  ;

-- 9. Loai bo tat ca quan he giua cac bang

-- 10.Xoa hoc vien co StudentID la 1


-- 11.Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1

alter table students
add studentstatus bit default 1;
-- 12.Cap nhap gia tri Status trong bang Student thanh 0 
alter table students
modify studentstatus bit default 0;