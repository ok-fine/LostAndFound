package entity;

import java.sql.SQLException;

public class SysAdmin {
    private int no;;
    private String name;
    private String tel;
    private String password;
    private String is_system;

    public SysAdmin(String name, String password, String tel){
        this.name = name;
        this.password = password;
        this.tel = tel;
        this.is_system = "1";
    }

    public SysAdmin(User user) throws SQLException {
        this.no = user.getNo();
        this.name = user.getName();
        this.tel = user.getTel();
        this.is_system = SysAdminMgr.is_sysAdmin(user);

    }

    public int getNo() {
        return no;
    }

    public String getName() {
        return name;
    }

    public String getTel() {
        return tel;
    }

    public String getPassword() {
        return password;
    }

    public String getIs_system() {
        return is_system;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
