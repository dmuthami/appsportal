/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.farmer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author dmuthami
 */
@WebServlet(name = "farmer", urlPatterns = {"/farmer"})
public class farmer extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet farmer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet farmer at " + request.getContextPath() + "</h1>");
            out.println("<h1>error : " + request.getAttribute("exError") + "</h1>");
            out.println("<h1>Farmers : " + request.getAttribute("table") + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        try {
           StringBuilder sb =  testConnection();
           request.setAttribute("table", sb.toString());

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(farmer.class.getName()).log(Level.SEVERE, null, ex);

            request.setAttribute("exError", ex.getMessage());
        } catch (SQLException ex) {
            Logger.getLogger(farmer.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("exError", ex.getMessage());
        }
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

    private StringBuilder testConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        Connection con = DriverManager.getConnection("jdbc:sqlserver://linode;databaseName=adims",
                "sa", "sa123");

        // Execute SQL query
        Statement stmt = con.createStatement();
        String sql;
        sql = "SELECT id, name, farmerid, lrnumber FROM farmcoordinate_to_farm_evw";
        ResultSet rs = stmt.executeQuery(sql);

        // Extract data from result set
        StringBuilder sb = new StringBuilder();
        sb.append("<Table>");
        sb.append("<tr> <th>ID</th><th>Name</th><th>Farmer ID</th><th>LR Number</th></tr>");

        while (rs.next()) {
            //Retrieve by column name
            int id = rs.getInt("id");
            String name = rs.getString("name");
            int farmerid = rs.getInt("farmerid");
            String lrnumber = rs.getString("lrnumber");

            //Display values
            sb.append("<tr> <td>" + id + "</td><td>" + name + "</td><td>" + farmerid + "</td><td>" + lrnumber + "</td></tr>");

        }
        sb.append("</Table>");

        // Clean-up environment
        rs.close();
        stmt.close();
        con.close();
        return sb;
    }

}
