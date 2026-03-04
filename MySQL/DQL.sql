show databases ;
/*
单表查询介绍:
    概述:
        所谓的单表查询, 指的是 按照一定的条件, 从一张SQL表中查出我们想要的结果数据.
    总的格式:
        select
            [distinct] 列名 [as 别名], 列名 [as 别名] ...
        from
            数据表名
        where
            组前筛选
        group by
            分组字段
        having
            组后筛选
        order by
            排序的列1 [asc | desc], 排序的列2 ...
        limit
            起始索引, 数据条数;
    细节:

-- 1. 语法
-- SELECT 字段列表 FROM 表名 LIMIT 起始索引, 查询记录数;

-- 注意
-- 起始索引从0开始，起始索引 = (查询页码 - 1) * 每页显示记录数。
-- 分页查询是数据库的方言，不同的数据库有不同的实现，MySQL中是LIMIT。
-- 如果查询的是第一页数据，起始索引可以省略，直接简写为limit 10。
 */

#删除itcast下的table中的tb_user
drop table if exists  tb_user;

#删除employee表
drop table if exists employee;


DROP TABLE IF EXISTS employee;

CREATE TABLE emp(
                    id INT COMMENT '编号',
                    workno VARCHAR(10) COMMENT '工号',
                    name VARCHAR(10) COMMENT '姓名',
                    gender CHAR(1) COMMENT '性别',
                    age TINYINT UNSIGNED COMMENT '年龄',
                    idcard CHAR(18) COMMENT '身份证号',
                    workaddress VARCHAR(50) COMMENT '工作地址',
                    entrydate DATE COMMENT '入职时间'
) COMMENT '员工表';

INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate)
VALUES
    (1, '1', '柳岩', '女', 20, '123456789012345678', '北京', '2000-01-01'),
    (2, '2', '张无忌', '男', 18, '123456789012345670', '北京', '2005-09-01'),
    (3, '3', '韦一笑', '男', 38, '123456789712345670', '上海', '2005-08-01'),
    (4, '4', '赵敏', '女', 18, '123456757123845670', '北京', '2009-12-01'),
    (5, '5', '小昭', '女', 16, '123456769012345678', '上海', '2007-07-01'),
    (6, '6', '杨逍', '男', 28, '12345678931234567X', '北京', '2006-01-01'),
    (7, '7', '范瑶', '男', 40, '123456789212345670', '北京', '2005-05-01'),
    (8, '8', '黛绮丝', '女', 38, '123456157123645670', '天津', '2015-05-01'),
    (9, '9', '范凉凉', '女', 45, '123156789012345678', '北京', '2010-04-01'),
    (10, '10', '陈友谅', '男', 53, '123456789012345670', '上海', '2011-01-01'),
    (11, '11', '张士诚', '男', 55, '123567897123465670', '江苏', '2015-05-01'),
    (12, '12', '常遇春', '男', 32, '123446757152345670', '北京', '2004-02-01'),
    (13, '13', '张三丰', '男', 88, '123656789012345678', '江苏', '2020-11-01'),
    (14, '14', '灭绝', '女', 65, '123456719012345670', '西安', '2019-05-01'),
    (15, '15', '胡青牛', '男', 70, '12345674971234567X', '西安', '2018-04-01'),
    (16, '16', '周芷若', '女', 18, nulL, '北京', '2012-06-01');

-- -------------------------- > 查询需求 <--------------------------

-- 基本查询
-- 1. 查询指定字段 name, workno, age 返回
select name, workno, age from emp ;

-- 2. 查询所有字段返回
select * from emp;

-- 3. 查询所有员工的工作地址，起别名
select workaddress as "工作地址" from emp;
select workaddress from emp;

-- 4. 查询公司员工的上班地址(不要重复)
select distinct emp.workaddress as "工作地址" from emp;

-- -------------------------- > 条件查询 <--------------------------

-- 1. 查询年龄等于 88 的员工
select * from emp where age = 88;
-- 2. 查询年龄小于 20 的员工信息
select  * from emp where age < 20;
-- 3. 查询年龄小于等于 20 的员工信息
select  * from emp where age <= 20;
-- 4. 查询没有身份证号的员工信息
select * from emp where idcard is null;
-- 5. 查询有身份证号的员工信息
select * from emp where idcard is not null;
-- 6. 查询年龄不等于 88 的员工信息
select * from emp where age != 88;
-- 7. 查询年龄在15岁(包含) 到 20岁(包含)之间的员工信息
select * from emp where age >= 15 and age <= 20;
select * from emp where age between 15 and 20;
-- 8. 查询性别为 女 且年龄小于 25岁的员工信息
select  * from emp where gender = '女' and age < 25;
-- 9. 查询年龄等于18 或 20 或 40 的员工信息
select * from emp where age = 18 or age = 20 or age = 40;
-- 10. 查询姓名为两个字的员工信息
select * from emp where name like '__';
-- 11. 查询身份证最后一位是X 的员工信息
select * from emp where idcard like '%X';

/*
_匹配单个字段
%匹配任意个字段
*/

-- -------------------------- > 聚合函数 <--------------------------
-- select 聚合函数【字段列表】from 表名;

-- 1. 统计该企业员工数量
-- 所有聚合函数不会统计null值
select count( *) from emp;
select count(idcard) from emp;
select count(id) from emp;

-- 2. 统计该企业员工的平均年龄
select avg(age) from emp; -- 40.1250

-- 3. 统计该企业员工的最大年龄
select max(age) from emp;

-- 4. 统计该企业员工的最小年龄
select min( age) from emp;

-- -------------------------- > 分组查询 <--------------------------
-- 1. 根据性别分组，统计男性员工和女性员工的数量
select gender , count(*) from emp group by gender ;
-- 2. 根据性别分组，统计男性员工和女性员工的平均年龄
select gender , avg(age) from emp group by gender ;
-- 3. 查询年龄小于45的员工，并根据工作地址分组，获取员工数量大于等于3的工作地址
select workaddress, count(*) from emp where age < 45 group by workaddress having count(*) >= 3;
# select后面的字段其实就是待会用的上的

-- -------------------------- > 排序 <--------------------------
-- 1. 根据年龄对公司的员工进行升序排序
select * from emp order by age asc;
-- 2. 根据入职时间，对员工进行降序排序
select * from emp order by entrydate desc;
-- 3. 根据年龄对公司的员工进行升序排序，年龄相同，再按照入职时间进行降序排序
select  * from emp order by age asc, entrydate desc;

-- -------------------------- > 分页查询 <--------------------------
-- 1. 查询第1页员工数据，每页展示10条记录
select * from emp limit 10;
-- 2. 查询第2页员工数据，每页展示10条记录, 偏移量offset,两种写法都可以
select * from emp limit 10 offset 10;
select * from emp limit 10,10;
-- 3. 获取第3页员工数据，每页展示10条记录
select * from emp limit 10 offset 20;


