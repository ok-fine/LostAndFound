package entity;

import db.*;

import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
    private int no;
    private int address_no;
    private String name;
    private String password;
    private String tel;

    public int getNo(){
        return this.no;
    }

    public int getAddress_no() {
        return address_no;
    }

    public String getName(){
        return this.name;
    }

    public String getPassword() {
        return this.password;
    }

    public String getTel() {
        return this.tel;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public void setAddress_no() throws SQLException {
        DBBean db = new DBBean();
        String sql = "SELECT address_no FROM address WHERE admin_no = " + this.no;
        ResultSet rset = db.select(sql);
        while(rset.next()){
            this.address_no = rset.getInt(1);
        }
    }

}
