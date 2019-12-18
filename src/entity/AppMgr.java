package entity;

import db.DBBean;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AppMgr {

    //获取用户的认领信息
    public static String[][] applications(int start, int user_no, String type) throws SQLException {
        int pageNum = DBBean.PageNum;

        DBBean db = new DBBean();
        String sql;
        if(type.equals("all")){
            sql = "SELECT a.apply_no, i.name, i.description, a.reason, a.apply_time, m.admin_name, m.tel, a.status, i.item_no " +
                    "FROM item_info AS i, applications AS a, admin_info AS m " +
                    "WHERE a.apply_item = i.item_no AND a.admin_no = m.admin_no AND a.apply_user = " + user_no +
                    " ORDER BY a.apply_time DESC LIMIT " + start + ", " + pageNum;
        }else{
            sql = "SELECT a.apply_no, i.name, i.description, a.reason, a.apply_time, m.admin_name, m.tel, a.status, i.item_no " +
                    "FROM item_info AS i, applications AS a, admin_info AS m " +
                    "WHERE a.apply_item = i.item_no AND a.admin_no = m.admin_no AND a.apply_user = " + user_no +
                    " AND a.status = '待审核' ORDER BY a.apply_time DESC LIMIT " + start + ", " + pageNum;
        }

        System.out.println(sql);

        ResultSet rset = null;
        rset = db.select(sql);

        //初始化数组
        String[][] applications = new String[pageNum + 1][];
        for(int j = 0 ; j <= pageNum; j++){
            applications[j] = new String[]{"0", "0", "0", "0", "0", "0", "0", "0", "0"};
        }
        int i = 0;
        while (rset.next()){
            applications[i][0] = String.valueOf(rset.getInt(1));
            applications[i][1] = rset.getString(2);
            applications[i][2] = rset.getString(3);
            applications[i][3] = rset.getString(4);
            applications[i][4] = rset.getString(5);
            applications[i][5] = rset.getString(6);
            applications[i][6] = rset.getString(7);
            applications[i][7] = rset.getString(8);
            applications[i][8] = String.valueOf(rset.getInt(9));
            i++;
        }

        //存放数组长度
        applications[pageNum][0] = String.valueOf(i);

        db.closeAll();
        return applications;
    }

    //获取管理员的审核信息
    public static String[][] orders(int start, int admin_no) throws SQLException {
        int pageNum = DBBean.PageNum;

        DBBean db = new DBBean();
        String sql = "SELECT a.apply_no, i.name, i.description, u.user_name, a.reason, a.get_time, u.tel " +
                "FROM item_info AS i, applications AS a, user_info AS u " +
                "WHERE a.apply_user = u.user_no AND a.apply_item = i.item_no AND " +
                "a.status = '待审核' AND a.admin_no = " + admin_no +
                " ORDER BY a.apply_time DESC LIMIT " + start + ", " + pageNum;

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
        DBBean db1 = new DBBean();

        String sql = "SELECT * FROM applications WHERE apply_item=" + item + " AND apply_user=" + user;
        String sql1 = "INSERT INTO applications(apply_user, apply_item, apply_time, get_time, reason, admin_no) " +
                "VALUES(" + user + ", " + item + ", '" + time + "', '" + g_time + "', '" + reason + "', " + ItemMgr.getAdmin(item) + ")";
        String sql2 = "UPDATE applications SET apply_time='" + time + "', get_time='" + g_time + "', reason='" + reason +
                "' WHERE apply_item=" + item + "AND apply_user=" + user;
        System.out.println(sql1);

        //一个人只能申请一个物品一次，但是可以修改申请
        ResultSet sset = db.select(sql);
        if(sset.next()){
            System.out.println("已申请过");
            apply_no = sset.getInt(1);
            edit(sset.getInt(1), time, g_time, reason);
        }else {
            System.out.println("未申请过");
            ResultSet rset = db1.insert(sql1);
            if(rset != null){
                apply_no = rset.getInt(1);
                System.out.println("申请成功:" + apply_no);
            }else {
                System.out.println("申请失败");
            }
            db1.closeAll();
        }

        db.closeAll();

        return apply_no;
    }

    public static void edit(int no, String time, String g_time, String reason){
        String sql = "UPDATE applications SET apply_time='" + time + "', get_time='" + g_time + "', reason='" + reason +
                "' WHERE apply_no=" + no;
        DBBean.update(sql);
    }

    public static void delete(int no){
        String sql = "DELETE FROM applications WHERE apply_no=" + no;
        DBBean.update(sql);

        System.out.println("delete:" + no);
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

            ItemMgr.claim(item_no);
        }else {
            System.out.println("通过失败");
        }
    }

    public static void refuse(String no, int admin){
        String sql = "UPDATE applications SET status = '拒绝' WHERE apply_no=" + no;
        DBBean.update(sql);
    }

}