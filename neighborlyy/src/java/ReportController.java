/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import java.io.InputStream;
import util.DBConnection;

@MultipartConfig
/**
 *
 * @author Dean Ardley
 */
public class ReportController extends HttpServlet {

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
        
        String accessType = request.getParameter("accessType");
        
        try{
        
            if(accessType.equals("add")){
                String userID = request.getParameter("userID");
                String reportDate = request.getParameter("reportDate");
                String location = request.getParameter("location");
                String remarks = request.getParameter("remarks");
                
                try{
                    Part filePart = request.getPart("attachment");
                    String fileName = filePart.getSubmittedFileName();
                    InputStream fileContent = filePart.getInputStream();
                    
                    Connection conn = DBConnection.createConnection();
                    PreparedStatement stmt = conn.prepareStatement("INSERT INTO report (userID, dateOfVisit, \"location\", remarks, attachment) VALUES (?, TO_DATE(?, 'YYYY:MM:DD'), ?, ?, ?)");
            
                    stmt.setInt(1, Integer.parseInt(userID));
                    stmt.setString(2, reportDate);
                    stmt.setString(3, location);
                    stmt.setString(4, remarks);
                    stmt.setString(5, fileName);
            
                    stmt.executeUpdate();
                    conn.close();
                    stmt.close();
                    
                }catch(Exception e){
                    if (e instanceof ClassNotFoundException) {
                        System.out.println("Oracle JDBC Driver not found.");
                    } else if (e instanceof SQLException) {
                        System.out.println("A database error occurred: " + e.getMessage());
                    } else {
                        System.out.println("An unexpected error occurred: " + e.getMessage());
                    }
                }
                             
                response.sendRedirect("./Admin/Report.jsp");
                              
            }else if(accessType.equals("update")){
                
                String reportID = request.getParameter("reportID");
                String userID = request.getParameter("userID");
                String reportDate = request.getParameter("reportDate");
                String location = request.getParameter("location");
                String remarks = request.getParameter("remarks");
                
                try{
                    Part filePart = request.getPart("attachment");
                    String fileName = filePart.getSubmittedFileName();
                    InputStream fileContent = filePart.getInputStream();
                    
                    Connection conn = DBConnection.createConnection();
                    PreparedStatement stmt = conn.prepareStatement("UPDATE report SET userID=?, dateOfVisit=TO_DATE(?, 'YYYY:MM:DD'), \"location\"=?, remarks=?, attachment=? WHERE reportID=?");
                    
                    stmt.setInt(1, Integer.parseInt(userID));
                    stmt.setString(2, reportDate);
                    stmt.setString(3, location);
                    stmt.setString(4, remarks);
                    stmt.setString(5, fileName);
                    stmt.setInt(6, Integer.parseInt(reportID));
                    
                    stmt.executeUpdate();
                    stmt.close();
                    conn.close();
                }catch(Exception e){
                    if (e instanceof ClassNotFoundException) {
                        System.out.println("Oracle JDBC Driver not found.");
                    } else if (e instanceof SQLException) {
                        System.out.println("A database error occurred: " + e.getMessage());
                    } else {
                        System.out.println("An unexpected error occurred: " + e.getMessage());
                    }
                }
                response.sendRedirect("./Admin/Report.jsp");
            
            }else if(accessType.equals("delete")){
                String reportID = request.getParameter("reportID");
                
                try{
                    Connection conn = DBConnection.createConnection();
                    PreparedStatement stmt = conn.prepareStatement("DELETE FROM report WHERE reportID=?");
                    stmt.setInt(1, Integer.parseInt(reportID));
                    stmt.executeUpdate();
                    
                    stmt.close();
                    conn.close();
                }catch(Exception e){
                    e.printStackTrace();
                }
                response.sendRedirect("./Admin/Report.jsp");
            }
                
        }catch(Exception e){
                e.printStackTrace();
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
