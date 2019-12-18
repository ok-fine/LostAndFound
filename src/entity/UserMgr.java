package entity;

import db.DBBean;

import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserMgr {

    private User user;

    public UserMgr(User user){
        this.user = user;
    }

    public void setInfo(String name, String password, String tel){
        this.user.setName(name);
        this.user.setPassword(password);
        this.user.setTel(tel);
    }

    public void changeInfo(int no, String name, String password, String tel){
        String sql = "UPDATE user_info SET user_name = '" + name
                + "', password = '" + password
                + "', tel = '" + tel + "' WHERE user_no = " + no;
        System.out.println(sql);

        int result = DBBean.update(sql);
        System.out.println(result);

        setInfo(name, password, tel);
    }

    public boolean register(String name, String password, String tel) throws SQLException {
        DBBean db = new DBBean();
        String sql = "INSERT INTO user_info(user_name, password, tel) " +
                "VALUES('" + name + "', '" + password + "', '" + tel + "')";
        System.out.println(sql);

        //不可以使用重复的名字
        String regSql = "SELECT * FROM user_info WHERE user_name = '" + name + "'";
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
                    this.user.setNo(rset.getInt(1));
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

    //普通的登陆，不用了基本
    public boolean login(){
        DBBean db = new DBBean();
        String sql = "SELECT * FROM user_info WHERE user_name = '" + this.user.getName()
                + "' AND password = '" + this.user.getPassword() + "'";
        System.out.println(sql);

        if(this.user.getName() == null || this.user.getPassword() == null){
            return false;
        }else {
            try {
                ResultSet rset = db.select(sql);
                if(rset.next()){
                    this.user.setNo(rset.getInt(1));
                    this.user.setTel(rset.getString(4));
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
            sql = "SELECT * FROM admin_info WHERE admin_name = '" + this.user.getName()
                    + "' AND password = '" + this.user.getPassword() + "'";
        }else {
            sql = "SELECT * FROM user_info WHERE user_name = '" + this.user.getName()
                    + "' AND password = '" + this.user.getPassword()+ "'";
        }
        System.out.println(sql);

        if(this.user.getName() == null || this.user.getPassword() == null){
            return false;
        }else {
            try {
                ResultSet rset = db.select(sql);
                if(rset.next()){
                    this.user.setNo(rset.getInt(1));
                    this.user.setTel(rset.getString(4));
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
