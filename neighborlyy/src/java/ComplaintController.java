


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import bean.ComplaintBean;
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
import java.sql.Date;
import java.text.SimpleDateFormat;

@MultipartConfig
/**
 *
 * @author Dean Ardley
 */
public class ComplaintController extends HttpServlet {

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
                              
            if(accessType.equals("update")){
                
                
                String complaintID = request.getParameter("complaintID");
                String userID = request.getParameter("userID");
                String statusID = request.getParameter("statusID");
                String complaintTypeID = request.getParameter("complaintTypeID");
                String description = request.getParameter("description");
                String complaintDate = request.getParameter("complaintDate");
                String complaintStatus = request.getParameter("complaintStatus");
                String location = request.getParameter("location");
                
                //To format the date 
                SimpleDateFormat fullFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    
                Date fullDate = (Date) fullFormat.parse(complaintDate);
                                                                                                             
                try{
                    Part filePart = request.getPart("attachment");
                    String fileName = filePart.getSubmittedFileName();
                    InputStream fileContent = filePart.getInputStream();
                    
                    //Implement Bean
                    ComplaintBean complaint = new ComplaintBean();
                    complaint.setComplaintType(Integer.parseInt(complaintTypeID));
                    complaint.setDescription(description);
                    complaint.setDateComplaint(fullDate);
                    complaint.setAttachment(fileName);
                    
                    Connection conn = DBConnection.createConnection();
                    PreparedStatement stmt = conn.prepareStatement("UPDATE complaint SET userID=?, statusID=?, complaint_type_ID=?, complaint_description=?, complaint_date=TO_DATE(?, 'YYYY:MM:DD'), complaint_status=?, complaint_location=?, complaint_attachment=? WHERE complaintID=?");
            
                    stmt.setInt(1, Integer.parseInt(userID));
                    stmt.setInt(2, Integer.parseInt(statusID));
                    stmt.setInt(3, Integer.parseInt(complaintTypeID));
                    stmt.setString(4, description);
                    stmt.setString(5, complaintDate);
                    stmt.setString(6, complaintStatus);
                    stmt.setString(7, location);
                    stmt.setString(8, fileName);
                    stmt.setInt(9, Integer.parseInt(complaintID));
                    
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
                             
                response.sendRedirect("./Admin/Complaint.jsp");
            }else if(accessType.equals("delete")){
                String complaintID = request.getParameter("complaintID");
                
                try{
                    Connection conn = DBConnection.createConnection();
                    PreparedStatement stmt = conn.prepareStatement("DELETE FROM complaint WHERE complaintID=?");
            
                    stmt.setInt(1, Integer.parseInt(complaintID));
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
                             
                response.sendRedirect("./Admin/Complaint.jsp");
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

