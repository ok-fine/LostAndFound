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

}
