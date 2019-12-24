package entity;

import db.DBBean;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SysAdminMgr {

    public static String is_sysAdmin(User user) throws SQLException {
        String is_sys = "0";
        DBBean db = new DBBean();

        String sql = "SELECT is_system FROM admin_info WHERE admin_no = " + user.getNo();
        ResultSet rset = db.select(sql);
        if(rset.next()){
           is_sys = rset.getString(1);
        }

        db.closeAll();

        return is_sys;
    }

    public static int addAdmin(SysAdmin sysAdmin) throws SQLException {
        int no = 0;
        DBBean db = new DBBean();
        String sql = "INSERT INTO admin_info(admin_name, password, tel, is_system) VALUES('" + sysAdmin.getName() +
                "', '" + sysAdmin.getPassword() + "', '" + sysAdmin.getTel() + "', '0')";

        ResultSet rset = db.insert(sql);
        if(rset.next()){
            no = rset.getInt(1);
        }

        return no;
    }

    public static int addAddress(String address, int admin_no) throws SQLException {
        int address_no = 0;
        DBBean db = new DBBean();
        String sql = "INSERT INTO address(address, admin_no) VALUES('" + address + "', " + admin_no + ")";

        ResultSet rset = db.insert(sql);
        if(rset.next()){
            address_no = rset.getInt(1);
        }

        return address_no;
    }

    public static String[][] getAdmins() throws SQLException {
        String[][] admins = new String[11][2];

        DBBean db = new DBBean();
        String sql = "SELECT admin_no, admin_name FROM admin_info";
        ResultSet rset = db.select(sql);

        int i = 0 ;
        while(rset.next()) {
            admins[i][0] = String.valueOf(rset.getInt(1));
            admins[i][1] = rset.getString(2);
            i++;
        }
        admins[10][0] = String.valueOf(i);

        db.closeAll();
        return admins;
    }

    public static void connect(int address_no, SysAdmin sysAdmin){
        String sql = "UPDATE address SET admin_no = " + sysAdmin.getNo() + " WHERE address_no = " + address_no;
        DBBean.update(sql);
    }
}
