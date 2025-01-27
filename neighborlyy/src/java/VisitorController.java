/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import bean.VisitorBean2;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import util.DBConnection;



/**
 *
 * @author Dean Ardley
 */
public class VisitorController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // Helper method to load the Oracle driver and get a database connection

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String accessType = request.getParameter("accessType");
        String action = request.getParameter("action");
        
        try{
        
            if(accessType.equals("add")){
                String userID = request.getParameter("userID");
                String visitorName = request.getParameter("visitorName");
                String visitorIC = request.getParameter("visitorIC");
                String plateNumber = request.getParameter("plateNumber");
                String entryTime = request.getParameter("entryTime");
                String exitTime = request.getParameter("exitTime");
                String visitDate = request.getParameter("visitDate");
                String purposeOfVisit = request.getParameter("purposeOfVisit");
                String phoneNumber = request.getParameter("phoneNumber");
                
                //Bean Implementation
                VisitorBean2 visitor = new VisitorBean2();
                visitor = new VisitorBean2(userID, visitorName, visitorIC, plateNumber, entryTime, exitTime, visitDate, purposeOfVisit, phoneNumber);
                
                
                try{               
                    Connection conn = DBConnection.createConnection();
                    PreparedStatement stmt = conn.prepareStatement("INSERT INTO visitor (userID, visitor_name, visitor_ic, no_plate, entryTime, exitTime, dateOfVisit, purposeOfVisit, visitor_phonenum) VALUES (?, ?, ?, ?, TO_TIMESTAMP(?, 'HH24:MI'), TO_TIMESTAMP(?, 'HH24:MI'), TO_DATE(?, 'YYYY:MM:DD'), ?, ?)");
            
                    stmt.setInt(1, Integer.parseInt(visitor.getUserID()));
                    stmt.setString(2, visitor.getVisitorName());
                    stmt.setString(3, visitor.getVisitorIC());
                    stmt.setString(4, visitor.getNoPlate());
                    stmt.setString(5, visitor.getEntryTime());
                    stmt.setString(6, visitor.getExitTime());
                    stmt.setString(7, visitor.getDateOfVisit());
                    stmt.setString(8, visitor.getPurposeOfVisit());
                    stmt.setString(9, visitor.getVisitorPhoneNum());
                    
                    stmt.executeUpdate();
                    stmt.close();
                    conn.close();
            
                }catch(Exception e){
                    e.printStackTrace();
                }
                response.sendRedirect("./Admin/Visitor.jsp");
                
            }else if(accessType.equals("update")){
                
                String registerID = request.getParameter("registerID");
                String userID = request.getParameter("userID");
                String visitorName = request.getParameter("visitorName");
                String visitorIC = request.getParameter("visitorIC");
                String plateNumber = request.getParameter("plateNumber");
                String entryTime = request.getParameter("entryTime");
                String exitTime = request.getParameter("exitTime");
                String visitDate = request.getParameter("visitDate");
                String purposeOfVisit = request.getParameter("purposeOfVisit");
                String phoneNumber = request.getParameter("phoneNumber");
                               
                VisitorBean2 editVisitor = new VisitorBean2(userID, visitorName, visitorIC, plateNumber, entryTime, exitTime, visitDate, purposeOfVisit, phoneNumber);
                
                try{
                    Connection conn = DBConnection.createConnection();
                    PreparedStatement stmt = conn.prepareStatement("UPDATE visitor SET userID=?, visitor_name=?, visitor_ic=?, no_plate=?, entryTime=TO_TIMESTAMP(?, 'HH24:MI'), exitTime=TO_TIMESTAMP(?, 'HH24:MI'), dateOfVisit=TO_DATE(?, 'YYYY:MM:DD'), purposeOfVisit=?, visitor_phonenum=? WHERE registerID=?");
            
                    stmt.setInt(1, Integer.parseInt(editVisitor.getUserID()));
                    stmt.setString(2, editVisitor.getVisitorName());
                    stmt.setString(3, editVisitor.getVisitorIC());
                    stmt.setString(4, editVisitor.getNoPlate());
                    stmt.setString(5, editVisitor.getEntryTime());
                    stmt.setString(6, editVisitor.getExitTime());
                    stmt.setString(7, editVisitor.getDateOfVisit());
                    stmt.setString(8, editVisitor.getPurposeOfVisit());
                    stmt.setString(9, editVisitor.getVisitorPhoneNum());
                    stmt.setInt(10, Integer.parseInt(registerID));
            
                    stmt.executeUpdate();
                    stmt.close();
                    conn.close();
            
                }catch(Exception e){
                    e.printStackTrace();
                }
                response.sendRedirect("./Admin/Visitor.jsp");
            }else if(accessType.equals("delete")){
                String registerID = request.getParameter("registerID");
                
                try{
                    Connection conn = DBConnection.createConnection();
                    PreparedStatement stmt = conn.prepareStatement("DELETE FROM visitor WHERE registerID=?");
                    
                    stmt.setInt(1, Integer.parseInt(registerID));
                    stmt.executeUpdate();
                    stmt.close();
                    conn.close();
                    
                }catch(Exception e){
                    e.printStackTrace();
                }
                response.sendRedirect("./Admin/Visitor.jsp");
                
            }else if(accessType.equals("search")){
                String searchVisitorName = request.getParameter("searchVisitorName");

                // Redirect to another JSP page with the visitor name in the query string
                response.sendRedirect("./Admin/SearchVisitor.jsp?searchVisitorName=" + searchVisitorName);
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
