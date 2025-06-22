/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StartupProjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import model.StartupProject;

/**
 *
 * @author MSI PC
 */
@WebServlet(name = "ProjectController", urlPatterns = {"/ProjectController"})
public class ProjectController extends HttpServlet {

    private static final String CREATE_PAGE = "CreateProject.jsp";
    private static final String DASHBOARD_PAGE = "Dashboard.jsp";

    protected String validateProject(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {

        String url = DASHBOARD_PAGE;
        StartupProjectDAO spDAO = new StartupProjectDAO();
        boolean check = true;

        String projectName = request.getParameter("projectName");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        Date launchDate = Date.valueOf(request.getParameter("launchDate"));
        int projectId;

        if ("update".equals(action)) {
            projectId = Integer.parseInt(request.getParameter("projectId"));
            Date oldLaunchDate = Date.valueOf(request.getParameter("oldLaunchDate"));
            if (launchDate.before(oldLaunchDate)) {
                request.setAttribute("errorDate", "New launch date must be after old launch date.");
                check = false;
            }
        } else {
            projectId = spDAO.createID();
            Date today = Date.valueOf(LocalDate.now());
            if (launchDate.before(today)) {
                request.setAttribute("errorDate", "Launch date must be in the future.");
                check = false;
            }
        }

        if (projectName == null || projectName.trim().length() < 3 || projectName.trim().length() > 100) {
            request.setAttribute("errorName", "Project name must be between 3 and 100 characters.");
            check = false;
        }

        if (description == null || description.trim().length() < 10) {
            request.setAttribute("errorDescription", "Description must be at least 10 characters.");
            check = false;
        }

        if (check) {
            StartupProject sp = new StartupProject(projectId, projectName, description, status, launchDate);

            boolean result = "update".equals(action) ? spDAO.update(sp) : spDAO.create(sp);
            if (result) {
                request.getSession().setAttribute("successMessage",
                        "update".equals(action) ? "Project updated successfully." : "Project created successfully.");
                url = DASHBOARD_PAGE;
                List<StartupProject> projs = spDAO.readAll();
                request.setAttribute("projects", projs);
            } else {
                request.setAttribute("error", "Database operation failed.");
                url = CREATE_PAGE;
            }
        } else {
            url = CREATE_PAGE;
            StartupProject spError = new StartupProject(projectId, projectName, description, status, launchDate);
            request.setAttribute("spError", spError);
            request.setAttribute("error", "Create/Update failed.");
        }
        return url;

    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = DASHBOARD_PAGE;;
        String action = request.getParameter("action");
        StartupProjectDAO spDAO = new StartupProjectDAO();

        try {
            //tao moi
            if ("create".equals(action)) {
                url = validateProject(request, response, action);
            } //tim kiem
            else if ("search".equals(action)) {
                String searchTerm = request.getParameter("searchTerm");
                System.out.println(searchTerm);
                List<StartupProject> list = spDAO.search(searchTerm);
                request.setAttribute("projectSearch", list);
                request.setAttribute("searchTerm", searchTerm);
                url = DASHBOARD_PAGE;
            } //truyen thong tin goi form de update
            else if ("updateGetPage".equals(action)) {
                int projectId = Integer.parseInt(request.getParameter("projectId"));
                StartupProject sp = spDAO.searchById(projectId);

                System.out.println(sp.getProjectId());
                request.setAttribute("startupProject", sp);
                url = CREATE_PAGE;
            } //cap nhat thong tin
            else if ("update".equals(action)) {
                url = validateProject(request, response, action);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Failed to create project: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
