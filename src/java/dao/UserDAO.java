/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import util.DBConnection;

/**
 *
 * @author MSI PC
 */
public class UserDAO {

    public static User checkLogin(String userName, String password) {
        String sql = "SELECT * FROM tblUsers WHERE Username = ? AND Password = ? ";
        User user = null;
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userName);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return user = new User(rs.getString("Username"),
                        rs.getString("Name"),
                        rs.getString("Password"),
                        rs.getString("Role"));

            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public List<User> readAll() {
        List<User> Users = new ArrayList<>();
        String sql = "SELECT * FROM tblUsers";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {  
                String Username = rs.getString("Username");
                String Name = rs.getString("Name");
                String Password = rs.getString("Password");
                String Role = rs.getString("Role");
                Users.add(new User(Username, Name, Password, Role));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Users;
    }

    public boolean update(User user) {
        String sql = "UPDATE tblUsers SET  Name = ?, Password = ?, Role = ? WHERE Username = ? ";
        boolean check = false;
        
        Connection conn;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole());
            ps.setString(4, user.getUserName());
            
            int rowsAffected = ps.executeUpdate();
            check = rowsAffected > 0;
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return check;
        
        
    }

}
