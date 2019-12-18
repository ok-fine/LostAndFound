package entity;

import db.DBBean;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ItemMgr {

    public static int getAdmin(int no) throws SQLException {
        DBBean db = new DBBean();
        int admin_no = 0;
        String sql = "SELECT admin_no FROM item_info WHERE item_no = " + no;

        ResultSet rset = db.select(sql);
        if(rset.next()){
            admin_no = rset.getInt(1);
        }

        System.out.println("admin_no:" + admin_no);

        db.closeAll();
        return admin_no;
    }

    public static String[] getInfo(int no) throws SQLException {
        String[] info = new String[]{"0", "0", "0", "0", "0", "0"};

        DBBean db = new DBBean();
        String sql = "SELECT i.name, i.description, i.time, a.address, m.admin_name, m.tel " +
                "FROM item_info AS i, address AS a, admin_info AS m WHERE item_no = " + no +
                " AND a.address_no = i.address_no AND m.admin_no = i.admin_no";

        ResultSet rset = db.select(sql);
        if(rset.next()){
            info[0] = rset.getString(1);
            info[1] = rset.getString(2);
            info[2] = rset.getString(3);
            info[3] = rset.getString(4);
            info[4] = rset.getString(5);
            info[5] = rset.getString(6);
        }

        System.out.println("认领失物名称：" + info[0]);

        db.closeAll();

        return info;
    }

    //认领物品
    public static boolean claim(int no){
        DBBean db = new DBBean();
        String sql = "UPDATE item_info SET status = '已认领' WHERE item_no = " + no;

        return DBBean.update(sql) != 0;
    }

    public static boolean delete(int no){
        DBBean db = new DBBean();
        String sql = "DELETE FROM item_info WHERE item_no = " + no;

        return DBBean.update(sql) != 0;
    }

    //发布失物
    public static void publish(String name, String description, String time, int address_no, int admin_no) throws SQLException {
        int no = 0;
        DBBean db = new DBBean();
        String sql = "INSERT INTO item_info(name, description, time, address_no, admin_no) " +
                "VALUES('" + name + "', '" + description + "', '" + time + "', " + address_no + ", " + admin_no + ")";

        ResultSet rset = db.insert(sql);
        while(rset.next()){
            no = rset.getInt(1);
        }

        db.closeAll();
    }

    //修改失物
    public static void edit(String no, String name, String description, String time) throws SQLException {
        String sql = "UPDATE item_info SET name = '" + name + "', description = '" + description + "', " +
                "time = '" + time + "' WHERE item_no = " + no;
        DBBean.update(sql);
    }

    //获取所有的待认领物品
    public static String[][] items(int start, int mine, int admin_no) throws SQLException {
        int pageNum = DBBean.PageNum;

        DBBean db = new DBBean();
        String sql;
        //1 - 全部，-1 - 我的
        if(mine == 1){
            sql = "SELECT i.item_no, i.name, description, time, a.address, m.admin_name, m.tel, m.admin_no " +
                    "FROM item_info AS i, address AS a, admin_info AS m WHERE status = '待认领' AND " +
                    "i.address_no = a.address_no AND i.admin_no = m.admin_no " +
                    "ORDER BY time DESC LIMIT " + start + ", " + pageNum;
        }else{
            sql = "SELECT i.item_no, i.name, description, time, a.address, m.admin_name, m.tel, m.admin_no " +
                    "FROM item_info AS i, address AS a, admin_info AS m WHERE status = '待认领' AND " +
                    "i.admin_no = " + admin_no + " AND i.address_no = a.address_no AND i.admin_no = m.admin_no " +
                    "ORDER BY time DESC LIMIT " + start + ", " + pageNum;
        }

        System.out.println(sql);

        ResultSet rset = null;
        rset = db.select(sql);

        //初始化数组
        String[][] items = new String[pageNum + 1][];
        for(int j = 0 ; j <= pageNum; j++){
            items[j] = new String[]{"0", "0", "0", "0", "0", "0", "0", "0"};
        }
        int i = 0;
        while (rset.next()){
            items[i][0] = String.valueOf(rset.getInt(1));
            items[i][1] = rset.getString(2);
            items[i][2] = rset.getString(3);
            items[i][3] = rset.getString(4);
            items[i][4] = rset.getString(5);
            items[i][5] = rset.getString(6);
            items[i][6] = rset.getString(7);
            items[i][7] = String.valueOf(rset.getInt(8));
            i++;
        }

        //存放数组长度
        items[pageNum][0] = String.valueOf(i);

        db.closeAll();
        return items;
    }
}
