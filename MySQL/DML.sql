insert into employee(id, workno, name, gender, age, idcard, entry_date)
values (1, '2019001', '张三', '男', 18, '111111111111111111', '2019-01-01');

# 修改某个字段的值
update employee set workno = '1' where id = 1;


# 查询所有数据
select *
from employee;

insert into employee
values (2, '2019002', '李四', '男', 19, '123456789012345678', '2019-01-02');
#这里因为没有写指定的字段，因而后面的每个values都必须按照顺序填写

#删除数据
delete
from employee
where id = 2;

# 修改数据
select *
from employee;

insert into employee
values (2, '2', '张无忌', '男', 18, '123456789012345670', '2005-01-01');


insert into employee
values (3, '3', '韦一笑', '男', 38, '123456789712345670', '2005-01-01'),
       (4, '4', '赵敏', '女', 18, '12345675712345670', '2005-01-01');

#删除符合条件的数据
delete from employee where gender = '女';

select  * from employee;

#删除所有
delete from employee;