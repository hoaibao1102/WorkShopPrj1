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
import model.StartupProject;
import util.DBConnection;

/**
 *
 * @author MSI PC
 */
public class StartupProjectDAO {

    public List<StartupProject> readAll() {
        List<StartupProject> projects = new ArrayList<>();
        String sql = "SELECT * FROM tblStartupProjects";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int projectId = rs.getInt("project_id");
                String projectName = rs.getString("project_name");
                String description = rs.getString("Description");
                String status = rs.getString("Status");
                Date estimatedLaunch = rs.getDate("estimated_launch");
                projects.add(new StartupProject(projectId, projectName, description, status, estimatedLaunch));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return projects;

    }

    public int createID() {
        String sql = " select top 1 project_id from tblStartupProjects order by project_id desc ";
        int projectId = 0;
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                projectId = rs.getInt("project_id");
            }

            conn.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(StartupProjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StartupProjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return projectId + 1;
    }

    public boolean update(StartupProject project) {
        String sql = "UPDATE tblStartupProjects SET project_name = ?, Description = ?, Status = ?, estimated_launch = ? WHERE project_id = ? ";
        boolean check = false;

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, project.getProjectName());
            ps.setString(2, project.getDescription());
            ps.setString(3, project.getStatus());
            ps.setDate(4, project.getEstimatedLaunch());
            ps.setInt(5, project.getProjectId());

            int rowEffect = ps.executeUpdate();
            check = rowEffect > 0;

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(StartupProjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StartupProjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return check;

    }

    public boolean create(StartupProject project) {
        String sql = "INSERT INTO tblStartupProjects (project_id, project_name, Description, Status, estimated_launch) VALUES(?,?,?,?,?)";
        boolean check = false;

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, project.getProjectId());
            ps.setString(2, project.getProjectName());
            ps.setString(3, project.getDescription());
            ps.setString(4, project.getStatus());
            ps.setDate(5, project.getEstimatedLaunch());

            int rowEffect = ps.executeUpdate();
            check = rowEffect > 0;

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(StartupProjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StartupProjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return check;

    }

    public StartupProject searchById(int projectId) {
        StartupProject sp = null;

        String sql = "Select * from tblStartupProjects where project_id = ? ";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                sp = new StartupProject(rs.getInt("project_id"),
                        rs.getString("project_name"),
                        rs.getString("Description"),
                        rs.getString("Status"),
                        rs.getDate("estimated_launch"));
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(StartupProjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StartupProjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return sp;
    }

    public List<StartupProject> search(String searchTerm) {
        List<StartupProject> projects = new ArrayList<>();
        String sql = "SELECT * FROM tblStartupProjects where project_name like ? or Description like ? or Status like ? or estimated_launch like ? ";
        String search = "%"+searchTerm+"%";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);
            
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int projectId = rs.getInt("project_id");
                String projectName = rs.getString("project_name");
                String description = rs.getString("Description");
                String status = rs.getString("Status");
                Date estimatedLaunch = rs.getDate("estimated_launch");
                projects.add(new StartupProject(projectId, projectName, description, status, estimatedLaunch));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return projects;
    }

}
