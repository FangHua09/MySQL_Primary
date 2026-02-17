/*
DML语句详解:
    概述:
        它叫数据操作语言, 主要是 操作 表数据, 进行 增删改操作的.
        实际开发中, 增删改统称为 -> 更新语句.
    细节:
        进行删除, 修改前, 一定一定一定要备份(或者加where条件), 一个过来人的含泪忠告!
    添加数据:
        格式:
            insert into 数据表名(列名1, 列名2...) values(值1, 值2...);
            insert into 数据表名 values(值1, 值2...);

            insert into 数据表名 values(值1, 值2...), (值1, 值2..)...;
        细节:
            1. 要添加的值的个数, 必须和 列名及其类型对应.
            2. 如果不写列名, 默认是: 全列名.

    修改数据:
        格式:
            update 数据表名 set 字段名=值, 字段名=值... where 条件;

    删除数据:
        格式:
            delete from 数据表名 where 条件;         不会重置主键id.
            truncate table 数据表名;                相当于把表摧毁了, 然后再创建一张一模一样的表, 即: 会重置主键id
 */

# --------------------------------- 案例1: DML语句(数据操作语言) 操作 表数据(data) 增 ---------------------------------
# 1. 切库, 查表.
use day01;
show tables;
drop table if exists stu;

# 2.创建分类表, 分类id, 分类名, 描述信息.
create table if not exists category(
    cid int,
    cname varchar(20),
    info varchar(100)
);

# 3. 往表中添加数据.
insert into category(cid, cname) values (1, '电脑');
# insert into category values (1, '电脑'); 假如列名没有, 则values必须全部写上，作为新行
insert into category values (2, '手机','iphone 17');

# 4. 添加多条数据
insert into category
values (3, '汽车', 'Tesla'),
       (4, '平板', 'Ipad 11');

# 5. 如何查看全表数据.
select * from category;
/*
1,电脑,
2,手机,iphone 17
3,汽车,Tesla
4,平板,Ipad 11
*/

# --------------------------------- 案例2: DML语句(数据操作语言) 操作 表数据(data) 改 ---------------------------------
# 1. 查看表数据.
select * from category;

# 2. 修改cname='空调', info='格力', cid=3
update category set cname = '空调', info = '格力' where cid = 3;
/*
1,电脑,
2,手机,iphone 17
3,空调,格力
4,平板,Ipad 11
*/
update category set cname='空调', info=null where cid = 3;
/*
1,电脑,
2,手机,iphone 17
3,空调,
4,平板,Ipad 11
*/


# --------------------------------- 案例3: DML语句(数据操作语言) 操作 表数据(data) 删 ---------------------------------
select * from category;
# 演示 delete from
delete
from category
where cid = 4;
/*
1,电脑,
2,手机,iphone 17
3,空调,
*/

delete from category;           # 一次性删除所有, 不会重置主键id

# 演示 truncate table
truncate table category;        # 依次删除所有, 会重置主键id(明天讲解, 目前先了解)


# --------------------------------- 案例4: 扩展_如何备份数据表 ---------------------------------
# 0. 查看数据表.
show tables;
# category
# category_bak
# student



# 1. 原表
select * from category;
/*
3,汽车,Tesla
4,平板,Ipad 11
2,手机,iphone 17
1,电脑,
*/

# 2. 场景1: 备份表不存在.
# 格式: create table 备份表名 select * from 原表名 where ...;
create table category_bak select * from category;

# 3. 场景2: 备份表存在. 即添加新数据到原备份表
# 格式: insert into 备份表名 select * from 原表名 where ...;
insert into category_bak select * from category;

# 4. 查看备份表数据.
select * from category_bak;

# 5. 清空备份表.
delete from category_bak;

# 6. 删除备份表.
drop table category_bak;

show tables;
#category
#student





