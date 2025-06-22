CREATE DATABASE WorkShop1

CREATE TABLE tblUsers (
    Username VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Founder', 'Team Member'))
);

CREATE TABLE tblStartupProjects (
    project_id INT PRIMARY KEY ,
    project_name VARCHAR(100) NOT NULL,
    Description TEXT,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Ideation', 'Development', 'Launch', 'Scaling')),
    estimated_launch DATE NOT NULL
);

INSERT INTO tblUsers (Username, Name, Password, Role) VALUES
('founder1', 'Alice Founder', '123', 'Founder'),
('member1', 'Bob Member', '123', 'Team Member');

INSERT INTO tblStartupProjects (project_id,project_name, Description, Status, estimated_launch) VALUES
(1,'GreenTech', 'Eco-friendly energy solutions', 'Ideation', '2025-09-01'),
(2,'EduNext', 'Online learning platform for remote areas', 'Development', '2025-08-15'),
(3,'FinSmart', 'AI-powered personal finance app', 'Launch', '2025-06-25'),
(4,'MedConnect', 'Healthcare appointment and records system', 'Scaling', '2025-10-10'),
(5,'AgriBoost', 'Smart farming sensor network', 'Development', '2025-07-12');


--test
  select top 1 project_id from tblStartupProjects 
  order by project_id desc

  INSERT INTO tblStartupProjects (project_id, project_name, description, status, estimated_launch)
VALUES (6, 'bookingWeb', 'heeeeelelelelelelel', 'Development', '2025-06-22');
