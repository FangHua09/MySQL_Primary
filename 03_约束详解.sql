/*
约束解释:
    概述:
        就是在数据类型的基础上, 进一步对某列值做限定.
    分类:
        单表约束:
            primary key: 主键约束, 特点: 非空, 唯一, 一般结合 自增(auto_increment)一起用.
                            #delete，truncate，不会/会重置自增字段的值
            not null: 非空约束
            unique:   唯一约束
            default:  默认约束
        多表约束:
            foreign key
*/

# ------------------------ 案例1:  演示主键约束 ------------------------
# 1. 建库, 切库, 查表.
drop database day02;
create database day02;
use day02;
show tables;

# 场景1: 建表时添加主键约束.
drop table student;
# 1. 创建学生表, 字段: id, name, age
create table student
(
    sid  int primary key auto_increment, # 学号,推荐使用auto_increment
    name varchar(10),     # 姓名
    age  int              # 年龄
    # , primary key(sid)    # 也可以这样去设置主键id
);

# 2. 查看表结构.
desc student;

# 3. 给student表添加数据.
insert into student values(1, '张三', 18);
insert into student values(1, '张三', 18);    # 报错, id重复
insert into student values(null, '张三', 18); # 报错, id不能为空(细节: 如果结合自增, 是可以传入null的)

# 4. 查看表数据.'
select * from student;

# 5. 删除主键约束.
alter table student drop primary key ;

# 6. 建表后, 添加主键约束, 结合 自增.
alter table student add primary key(sid);
alter table student modify sid int auto_increment;  # 增加 自增功能

# 7. 再次尝试往表中添加数据.（主键列会自动加，所以可以传入null）
insert into student values (null, '李四', 20);
/*
1,张三,18
2,李四,20
**/

insert into student values(10, '王五', 20);
insert into student values(null, '赵六', 66);

select  * from student; #所以说主键可以不连续，但是不能重复
/*
1,张三,18
2,李四,20
10,王五,20
11,赵六,66
*/

# 回顾: delete from (不会重置主键id),  truncate table (重置主键id)
select  * from student;
/*
1,张三,18
2,李四,20
10,王五,20
11,赵六,66
12,赵六,66
13,赵六,66
14,赵六,66
15,赵六,66
*/

delete from student;#删除所有数据，不会重置主键id
#16,赵六,66 假如新增，则顺着主键往下

/*
16,赵六,66
17,赵六,66
18,赵六,66
19,赵六,66
20,赵六,66
21,赵六,66
*/

truncate table student;
insert into student values(null, '赵六', 66); # 会重置主键id, 相当于把表摧毁了, 然后创建一张和原表一模一样的新表.
#1,赵六,66


# ------------------------ 案例2:  演示主键约束 ------------------------
# 1. 查表
show tables; #student
#employee


# 2. 建表, 员工表(employee), 字段(员工id, 员工姓名, 员工的手机号, 员工性别, 员工住址)
create table employee
(
    eid    int primary key auto_increment,
    ename  varchar(20) not null ,
    gender char(2) unique , #假如还设置了not null 就叫唯一主键列
    addr   varchar(100) default '中国'
);

# 3. 查看表结构
desc employee;
/*
primary key → 强制 NOT NULL + UNIQUE。
auto_increment → 提供一个自动生成值的便利方式。
所以，eid 作为主键，NULL 列显示为 NO 是完全正确的，这和你是否使用 auto_increment 无关。**/

# 4. 添加数据
alter table employee modify gender char(10);
insert into employee values(null, '乔峰', '111', '南院');
insert into employee values(null, null, '222', '缥缈峰');   # 报错, 姓名不能为空
insert into employee values(null, '乔峰', '111', '缥缈峰');  # 报错, 手机号必须唯一
insert into employee values(null, '乔峰', '222', '缥缈峰');  # 可以

insert into employee values(null, '段誉', '333'); # 报错, 值的个数要和列的个数一致, 这里没写列, 默认是: 全列名.
insert into employee(eid,ename,addr) values(null, '段誉', '333');    # 可以

# 5. 查看表数据.
select * from employee;
/*
1,乔峰,111,南院
3,乔峰,222,缥缈峰
4,段誉,,333
*/