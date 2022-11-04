use bai5_bai3;
create table test(
testid int primary key auto_increment,
testname varchar(20) not null
);
create table Students(
RN int primary key auto_increment,
Sname varchar(20) not null,
age tinyint not null
);
create table studenttest(
RN int not null,
testid int not null,
datetest date,
mark float,
foreign key(RN) references Students(RN),
foreign key(testid) references test(testid)
);
insert into students(Sname,age)values
('Nguyen Hong Ha', 20 ),
('Truong Ngoc Anh', 30 ),
('Tuan Minh', 25 ),
('Dan Truong', 22 );
insert into test(testname) values('EPC'),('DWMX'),('SQL1'),('SQL2');
insert into studenttest(RN,testid,datetest,mark)values
(1 ,1, '2006-07-17', 8 ),
(1 ,2, '2006-07-18', 5 ),
(1 ,3, '2006-07-19', 7 ),
(2 ,1, '2006-07-17', 7 ),
(2 ,2, '2006-07-18', 4 ),
(2 ,3, '2006-07-19', 2 ),
(3 ,1, '2006-07-17', 10 ),
(3 ,3, '2006-07-18', 1 );
alter table students 
modify age int check(age between 15 and 55);
alter table studenttest
modify mark float default 0;
alter table studenttest
add primary key(RN,TestID);
alter table Test
modify testname varchar(20) unique;
alter table Test
modify testname varchar(20) not null;
alter table studenttest
modify datetest datetime
-- Hiển thị danh sách các học viên đã tham gia thi, các môn thi được thi bởi các học viên đó, điểm thi và ngày thi
select s.Sname, t.testname, stt.mark, stt.datetest 
from students s inner join studenttest stt on s.RN=stt.RN inner join test t on stt.testid=t.testid
-- Hiển thị danh sách các bạn học viên chưa thi môn nào như hình sau: 
select *from students
where RN not in (select stt.RN from  studenttest stt)
-- Hiển thị danh sách học viên phải thi lại, tên môn học phải thi lại và điểm thi(điểm phải thi lại là điểm nhỏ hơn 5)

select s.Sname, t.testname, stt.mark,stt.datetest 
from students s inner join studenttest stt on s.RN=stt.RN inner join test t on stt.testid=t.testid
where stt.mark<5
-- Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi. 
-- Danh sách phải sắp xếp theo thứ tự điểm trung bình giảm dần
select s.Sname,  avg(stt.mark) as Average
from students s inner join studenttest stt on s.RN=stt.RN 
group by s.RN
order by avg(stt.mark) DESC;
 -- Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất
 select s.Sname, avg(stt.mark) as Average
from students s inner join studenttest stt on s.RN=stt.RN 
group by s.RN
having avg(stt.mark)>=all(select avg(stt.mark) as Average
from students s inner join studenttest stt on s.RN=stt.RN 
group by s.RN)
-- 8. Hiển thị điểm thi cao nhất của từng môn học. Danh sách phải được sắp xếp theo tên môn học như sau: 
select t.testname, max(mark)as 'Max MArk'
from studenttest stt inner join test t on stt.testid=t.testid
group by stt.testid
order by t.testname
-- 9. Hiển thị danh sách tất cả các học viên và môn học mà các học viên đó đã thi nếu
-- học viên chưa thi môn nào thì phần tên môn học để Null.
select s.sname, t.testname
from test t left join studenttest st on t.testid=st.testid right join students s on st.RN=s.RN
