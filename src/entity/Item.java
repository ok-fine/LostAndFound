package entity;

import db.DBBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Item {
    private int item_no;

    Item(int no){
        this.item_no = no;
    }

    public int getItem_no() {
        return item_no;
    }

    public void setItem_no(int item_no) {
        this.item_no = item_no;
    }

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


    //获取所有的待认领物品
    public static String[][] items(int start) throws SQLException {
        int pageNum = 2;

        DBBean db = new DBBean();
        String sql = "SELECT i.item_no, i.name, description, time, a.address, m.admin_name, m.tel, m.admin_no " +
                "FROM item_info AS i, address AS a, admin_info AS m WHERE status = '待认领' AND " +
                "i.address_no = a.address_no AND i.admin_no = m.admin_no " +
                "ORDER BY time DESC LIMIT " + start + ", " + pageNum;

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
            items[i][7] = rset.getString(8);
            i++;
        }

        //存放数组长度
        items[pageNum][0] = String.valueOf(i);

        db.closeAll();
        return items;
    }
}
