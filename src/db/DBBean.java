package db;

import java.sql.*;

public class DBBean {
    /**
     *
     * @return
     */
    private static Connection conn = null;
    private static Statement stmt = null;
    private static ResultSet rset = null;
    private static PreparedStatement pstmt = null;

    public static Connection getConnection(){
//        Connection conn = null;
        try{
            //注册驱动
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("注册驱动成功");
            //获取数据库连接对象
            String url = "jdbc:mysql://localhost:3306/lost_and_found?useUnicode=true&characterEncoding=utf8"
                    + "&user=root&password=game123456";

//            //可以用变量的方式连接，也可以语言连接
//            String user = "root";
//            String password = "game123456";
//            conn = DriverManager.getConnection(url, user, password);
            conn = DriverManager.getConnection(url);
            return conn;
        }catch (Exception e){
            e.printStackTrace();
        }

        return conn;
    }

    //sql一般是（insert、update、delete）
    public static int update(String sql){
        int count = -1;
//        Connection conn = null;
//        Statement stmt = null;
//        ResultSet rset = null;
        try{
            conn = getConnection();
            stmt = conn.createStatement();
            count = stmt.executeUpdate(sql);

            System.out.println(sql);
        }catch (Exception e1){
            e1.printStackTrace();
        } finally {
            try{
                stmt.close();
                conn.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        return count;
    }

    //能够返回insert后的默认参数
    public ResultSet insert(String sql){
        ResultSet rset = null;

        try{
            conn = getConnection();
            pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

            int result = pstmt.executeUpdate();
            if(result != 0){
                rset = this.pstmt.getGeneratedKeys();
                //没有参数就返回空
                if(!rset.next()){
                    rset = null;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return rset;
    }

    //sql一般未查询语句
    //为了能处理返回的rset所以此处不需要final close（）；
    public ResultSet select(String sql) {
//        Connection conn = null;
//        Statement stmt = null;
//        ResultSet rset = null;

        try {
            conn = getConnection();
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);

            System.out.println(sql);
        } catch (SQLException e1) {
            System.err.println("Data.executeQuery: " + e1.getMessage());
        }
        return rset;
    }

    //sql为任意语句
    public static boolean query(String sql) {
        boolean result = false;
//        Connection conn = null;
//        Statement stmt = null;

        try {
            conn = getConnection();
            stmt = conn.createStatement();
            result = stmt.execute(sql);

            System.out.println(sql);

        } catch (SQLException e1) {
            System.err.println("Data.executeQuery: " + e1.getMessage());
        }finally {
            try{
                stmt.close();
                conn.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }

        return result;
    }

    public void closeStmt()
    {
        try {
            stmt.close();
        } catch (SQLException e) {
            System.err.println("Data.executeQuery: " + e.getMessage());
        }
    }

    public void closePstmt(){
        try{
            pstmt.close();
        } catch (SQLException e) {
            System.err.println("Data.executeQuery: " + e.getMessage());
        }
    }

    public void closeConn() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.err.println("Pstmt.executeQuery: " + e.getMessage());
        }
    }

    public void closeAll() {
        /*
        不能放到同一个try、catch语句中：
        如果某一个在close过程中出现异常抛出，后面的将无法关闭资源
         */
        try {
            if (rset != null) rset.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            if (stmt != null) stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            if (conn != null) conn.close();
        } catch (SQLException e)
        {
            e.printStackTrace();
        }
    }
}
