create database quanlysinhvien2;
use quanlysinhvien2;

create table Students(
StudentID int primary key auto_increment,
StudentName varchar(45),
Age int,
Email varchar(45)
);
insert into students(StudentName, Age, Email) values
("Nguyen Quang An", 18, "an@yahoo.com"),
("Nguyen Cong Vinh", 20, "vinh@gmail.com"),
("Nguyen Van Quyen", 19, "quyen@gmail.com"),
("Pham Thanh Binh", 25, "binh@gmail.com"),
("Nguyen Van Tai Em", 30, "taiem@sport.com");

create table Classes(
ClassID int primary key auto_increment,
ClassName varchar(20)
);
insert into classes(ClassName) values
("C0706L"),
("C0708G");
select * from classes;

create table Subjects(
SubjectID int primary key auto_increment,
SubjectName varchar(45)
);
insert into subjects(SubjectName) values
("SQL"),
("Java"),
("C"),
("Visual Basic");

create table ClassStudent(
StudentID int,
ClassID int,
foreign key(StudentID) references Students (StudentID),
foreign key(ClassID) references Classes (ClassID)
);
insert into classstudent(StudentID, ClassID) values
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 2);
select * from classstudent;



create table Marks(
Mark int,
SubjectID int,
StudentID int,
foreign key (SubjectID) references Subjects (SubjectID),
foreign key (StudentID) references Students (StudentID)
);
insert into marks(Mark, SubjectID, StudentID) values
(8, 1, 1),
(4, 2, 1),
(9, 1, 1),
(7, 1, 3),
(3, 1, 4),
(5, 2, 5),
(8, 3, 3),
(1, 3, 5),
(3, 2, 4);
select * from marks;

-- Câu 1: Hiển thị danh sách tất cả các học viên:
select * from students;
-- Câu 1.1: Hiển thị danh sác tất cả các học viên có tuổi lớn hơn hoặc bằng 25.
select * from students where Age >= 25;

-- Câu 2: Hiển thị danh sách tất cả các môn học.
select * from subjects;
-- Câu 2.1: Hiển thị danh sách học sinh và lớp học.
select Students.StudentName, Classes.ClassName
from Students join ClassStudent on Students.StudentID = ClassStudent.StudentID
join Classes on ClassStudent.ClassID = Classes.Cl;
 
-- Câu 3: Tính điểm trung bình.
select m.StudentID, s.StudentName, avg(m.Mark) as DiemTBSV
from Marks as m 
join Students as s on s.StudentID = m.StudentID
group by m.StudentID;

-- Câu 4: Hiển thị môn học có học sinh thi được điểm cao nhất.
select SubjectName, max(Mark) as maxMark from Subjects
inner join marks on Subjects.SubjectID = marks.subjectID;

-- Câu 5: Đánh số thứ tự của điểm theo chiều giảm.
select row_number() over (order by mark desc) as 'Số thứ tự', students.studentId, students.studentName, mark, subjectName, className from students
inner join marks on students.studentId = marks.studentId
inner join subjects on marks.subjectId = subjects.subjectId
inner join classStudent on students.studentId = classStudent.StudentId
inner join classes on classes.classId = classStudent.classId;

-- Câu 6: Thay đổi kiểu dữ liệu của cột SubjectName trong bảng Subjects thanh nvarchar(max).
alter table subjects
modify column subjectName varchar(255);

-- Câu 7: Cập nhật thêm dòng chữ " Đây là môn học " vào trước các bản ghi trên cột SubjectName trong bảng Subjects.
update subjects set subjectName = concat('Đây là môn học ', subjectName);

-- Câu 8: Viết check Constraint để kiểm tra độ tuổi nhập vào trong bảng Student yêu cầu Age > 15 và Age < 50.
alter table Students add constraint age check (age between 15 and 55);

-- Câu 9: Loại bỏ tất cả quan hệ giữa các bảng.
-- Tắt khóa ngoại: 
set foreign_key_checks = 0;
-- Bật khóa ngạoi:
set foreign_key_checks = 1;

-- Câu 10: Xóa học viên có StudentID là 1:
delete from Students where StudentID = 1;

-- Câu 11: Trong bảng Students thêm một cột column Status co kiểu dữ liệu là Bit có giá trị là Default là 1.
alter table Students
add Status bit default 1;
 
 -- Câu 12: Cập nhật giá trị Status trong bảng Students thành 0.
 update Students set status = 0;