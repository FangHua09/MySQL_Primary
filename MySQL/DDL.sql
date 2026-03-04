show databases ; # 查看数据库

create database if not exists db_demo; # 创建数据库

use itcast; # 选择数据库

select database(); # 查看当前数据库

drop database db_demo; # 删除数据库

show tables ;

create table if not exists emp
(
    id         int comment '编号',
    work_id    varchar(10) comment '工号',
    name       varchar(20) comment '姓名',
    age        tinyint unsigned comment '年龄',
    idcard     char(18) comment '身份证',
    entry_date date comment '入职时间'
) comment '员工表';

desc emp;

# 添加字段
alter table emp add nickname varchar(20) comment '昵称';

# 修改字段类型和字段名称
alter table emp change nickname username varchar(20) comment '用户名';

# 仅修改字段类型
alter table emp modify username varchar(30) comment '用户名';

# 删除字段
alter table emp drop username;

# 修改表名
alter table emp rename to employee;

# 表名已经被修改完成
desc employee;

# 删除表
drop table if exists  tb_user;# 如果表被引用, 则删除失败

truncate table  tb_user; # 删除表内所有数据, 保留表结构

show tables;
/*employee
tb_user
*/






