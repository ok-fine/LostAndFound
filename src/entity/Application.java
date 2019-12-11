package entity;

import db.DBBean;

import entity.Item;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Application {
    private int apply_no;

    Application(int no){
        this.apply_no = no;
    }

    public int getApply_no() {
        return apply_no;
    }

    public void setApply_no(int apply_no) {
        this.apply_no = apply_no;
    }

    //获取管理员的审核信息
    public static String[][] oeders(int start, int admin_no) throws SQLException {
        int pageNum = 2;

        DBBean db = new DBBean();
        String sql = "SELECT a.apply_no, i.name, i.description, u.user_name, a.reason, a.get_time, u.tel " +
                "FROM item_info AS i, applications AS a, user_info AS u " +
                "WHERE a.apply_user = u.user_no AND a.apply_item = i.item_no AND " +
                "a.status = '待审核' AND a.admin_no = " + admin_no +
                " ORDER BY a.apply_time DESC LIMIT " + start + ", " + (start + pageNum);

        System.out.println(sql);

        ResultSet rset = null;
        rset = db.select(sql);

        //初始化数组
        String[][] orders = new String[pageNum + 1][];
        for(int j = 0 ; j <= pageNum; j++){
            orders[j] = new String[]{"0", "0", "0", "0", "0", "0", "0"};
        }
        int i = 0;
        while (rset.next()){
            orders[i][0] = String.valueOf(rset.getInt(1));
            orders[i][1] = rset.getString(2);
            orders[i][2] = rset.getString(3);
            orders[i][3] = rset.getString(4);
            orders[i][4] = rset.getString(5);
            orders[i][5] = rset.getString(6);
            orders[i][6] = rset.getString(7);
            i++;
        }

        //存放数组长度
        orders[pageNum][0] = String.valueOf(i);

        db.closeAll();
        return orders;
    }

    //认领
    public static int apply(int user, int item, String time, String g_time, String reason) throws SQLException {
        int apply_no = 0;
        DBBean db = new DBBean();
        String sql = "SELECT * FROM application WHERE apply_item=" + item + "AND apply_user=" + user;
        String sql1 = "INSERT INTO applications(apply_user, apply_item, apply_time, get_time, reason, admin_no) " +
                "VALUES(" + user + ", " + item + ", " + time + ", " + g_time + ", " + reason + ", " + Item.getAdmin(item) + ")";
        String sql2 = "UPDATE applications SET apply_time=" + time + ", get_time=" + g_time + ", reason=" + reason +
                " WHERE apply_item=" + item + "AND apply_user=" + user;

        //一个人只能申请一个物品一次，但是可以修改申请
        ResultSet sset = db.select(sql);
        if(sset.next()){
            edit(sset.getInt(1), time, g_time, reason);
        }else {
            ResultSet rset = db.insert(sql1);
            if(rset.next()){
                apply_no = rset.getInt(1);
            }else {
                System.out.println("申请失败");
            }
        }

        return apply_no;
    }

    public static void edit(int no, String time, String g_time, String reason){
        String sql = "UPDATE applications SET apply_time=" + time + ", get_time=" + g_time + ", reason=" + reason +
                " WHERE apply_no=" + no;
        DBBean.update(sql);
    }

    public static void delete(int no){
        String sql = "DELETE FROM application WHERE apply_no=" + no;
        DBBean.update(sql);
    }

    //通过申请后需要认领物品
    public static void pass(String  no, int admin) throws SQLException {
        int item_no;
        DBBean db = new DBBean();
        String sql = "SELECT apply_item FROM applications WHERE apply_no=" + no;
        ResultSet rset = db.select(sql);
        if(rset.next()){
            item_no = rset.getInt(1);

            String sql1 = "UPDATE applications SET status = '拒绝' WHERE apply_item=" + item_no;
            String sql2 = "UPDATE applications SET status = '通过' WHERE apply_no=" + no;
            DBBean.update(sql1);
            DBBean.update(sql2);

            Item.claim(item_no);
        }else {
            System.out.println("通过失败");
        }
    }

    public static void refuse(String no, int admin){
        String sql = "UPDATE applications SET status = '拒绝', WHERE apply_no=" + no;
        DBBean.update(sql);
    }
}
