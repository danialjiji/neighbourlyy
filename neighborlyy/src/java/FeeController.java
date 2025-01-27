/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import bean.FeeBean;
import bean.FeeBean2;
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
public class FeeController extends HttpServlet {

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
                String feeCategoryID = request.getParameter("feeCategoryID");
                String statusID = request.getParameter("statusID");
                String feeDate = request.getParameter("feeDate");
                int feeAmount = Integer.parseInt(request.getParameter("feeAmount"));              
                                            
                try{
                    
                    
                    //Bean Implementation
                    FeeBean2 fee = new FeeBean2(userID, feeCategoryID, statusID, feeDate, feeAmount);
                  
                    
                    Connection conn = DBConnection.createConnection();
                    PreparedStatement stmt = conn.prepareStatement("INSERT INTO fee (userID, fee_category_ID, statusID, fee_date, fee_amount) VALUES (?, ?, ?, TO_DATE(?, 'YYYY:MM:DD'), ?)");
            
                    stmt.setInt(1, Integer.parseInt(fee.getUserID()));
                    stmt.setString(2, fee.getFeeCategoryID());
                    stmt.setString(3, fee.getStatusID());
                    stmt.setString(4, fee.getFeeDate());
                    stmt.setInt(5, fee.getFeeAmount());                  
                           
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
                             
                response.sendRedirect("./Admin/Fee.jsp");
                              
            }else if(accessType.equals("update")){
                
                String feeID = request.getParameter("feeID");
                String userID = request.getParameter("userID");
                String feeCategoryID = request.getParameter("feeCategoryID");
                String statusID = request.getParameter("statusID");
                String feeDate = request.getParameter("feeDate");
                int feeAmount = Integer.parseInt(request.getParameter("feeAmount"));
                
                
                try{
                    
                    //Bean Implementation
                    FeeBean2 editFee = new FeeBean2(userID, feeCategoryID, statusID, feeDate, feeAmount);                   
                    
                    Connection conn = DBConnection.createConnection();
                    PreparedStatement stmt = conn.prepareStatement("UPDATE fee SET userID=?, fee_category_ID=?, statusID=?, fee_date=TO_DATE(?, 'YYYY:MM:DD'), fee_amount=? WHERE feeID=?");
            
                    stmt.setInt(1, Integer.parseInt(editFee.getUserID()));
                    stmt.setInt(2, Integer.parseInt(editFee.getFeeCategoryID()));
                    stmt.setInt(3, Integer.parseInt(editFee.getStatusID()));
                    stmt.setString(4, editFee.getFeeDate());
                    stmt.setInt(5, editFee.getFeeAmount());
                    
                    
                    stmt.setInt(6, Integer.parseInt(feeID));
                    
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
                             
                response.sendRedirect("./Admin/Fee.jsp");
                          
            }else if(accessType.equals("delete")){
                String feeID = request.getParameter("feeID");
                
                try{
                    
                    
                    Connection conn = DBConnection.createConnection();
                    PreparedStatement stmt = conn.prepareStatement("DELETE FROM fee WHERE feeID=?");
            
                    stmt.setInt(1, Integer.parseInt(feeID));
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
                             
                response.sendRedirect("./Admin/Fee.jsp");
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
