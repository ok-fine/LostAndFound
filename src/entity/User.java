package entity;

import db.*;

import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
    private int no;
    private String name;
    private String password;
    private String tel;

    public int getNo(){
        return this.no;
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

    public void setInfo(String name, String password, String tel){
        setName(name);
        setPassword(password);
        setTel(tel);
    }

    public void changeInfo(int no, String name, String password, String tel){
        DBBean db = new DBBean();
        String sql = "UPDATE user_info SET user_name = \'" + name
                + "\', password = \'" + password
                + "\', tel = \'" + tel + "\' WHERE user_no = " + no;
        System.out.println(sql);

        int result = db.update(sql);
        System.out.println(result);

        setName(name);
        setPassword(password);
        setTel(tel);
    }

    public boolean register() throws SQLException {
        DBBean db = new DBBean();
        String sql = "INSERT INTO user_info(user_name, password, tel) " +
                "VALUES(\'" + this.name + "\', \'" + this.password + "\', \'" + this.tel + "\')";
        System.out.println(sql);

        //不可以使用重复的名字
        String regSql = "SELECT * FROM user_info WHERE user_name = \'" + this.name + "\'";
        try {
            ResultSet rset = db.select(regSql);
            if(rset.next()){
                return false;
            }else {

                //插入需要注册的数据
                rset = db.insert(sql);
                if (rset == null) {
                    System.out.println("注册失败");
                    return false;
                } else {
                    System.out.println("注册成功");
                    setNo(rset.getInt(1));
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.closeAll();
        }

        return false;
    }

    public boolean login(){
        DBBean db = new DBBean();
        String sql = "SELECT * FROM user_info WHERE user_name = \'" + this.name
                + "\' AND password = \'" + this.password + "\'";
        System.out.println(sql);

        if(this.name == null || this.password == null){
            return false;
        }else {
            try {
                ResultSet rset = db.select(sql);
                if(rset.next()){
                    setNo(rset.getInt(1));
                    setTel(rset.getString(4));
                    return true;
                }else {
                    return false;
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }finally {
                db.closeAll();
            }

            return false;
        }
    }

    //root = 0,普通用户     root = 1，管理员
    public boolean login(String root){
        DBBean db = new DBBean();

        String sql = "";
        if( root != null && root.equals("on")){
            sql = "SELECT * FROM admin_info WHERE admin_name = \'" + this.name
                    + "\' AND password = \'" + this.password + "\'";
        }else {
            sql = "SELECT * FROM user_info WHERE user_name = \'" + this.name
                    + "\' AND password = \'" + this.password + "\'";
        }
        System.out.println(sql);

        if(this.name == null || this.password == null){
            return false;
        }else {
            try {
                ResultSet rset = db.select(sql);
                if(rset.next()){
                    setNo(rset.getInt(1));
                    setTel(rset.getString(4));
                    return true;
                }else {
                    return false;
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }finally {
                db.closeAll();
            }

            return false;
        }
    }

    public void exit(HttpSession session){
        session.setAttribute("login", "-1");
    }

}
