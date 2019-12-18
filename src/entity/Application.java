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

}
