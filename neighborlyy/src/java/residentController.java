/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import bean.ComplaintBean;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import util.DBConnection;
/**
 *
 * @author soleha
 */
@MultipartConfig
@WebServlet(urlPatterns = {"/residentController"})
public class residentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
           String accessType = request.getParameter("accessType");

        if ("addComplaints".equalsIgnoreCase(accessType)) {
           addComplaints (request, response);
        } else if ("deleteComplaint".equalsIgnoreCase(accessType)) {
           deleteComplaints (request, response);
        }else 
        {
            try (PrintWriter out = response.getWriter()) {
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Invalid Access Type</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Invalid access type: " + accessType + "</h1>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }
    
    private void addComplaints (HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String complaintTypeStr = request.getParameter("complaintType");
        String date = request.getParameter("dateComplaint");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String useridStr = request.getParameter("userid");

         
          try {
            int userid = Integer.parseInt(useridStr);
            int complaintType = Integer.parseInt(complaintTypeStr);
            java.sql.Date sqlDate = java.sql.Date.valueOf(date);
            Part filePart = request.getPart("attachment");
            if (filePart == null) {
                request.setAttribute("message", "No file uploaded");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            
            String fileName = filePart.getSubmittedFileName();
            
             //for uploading file into specific folder
            String uploadDirectory = "C:/Users/Nurin Atikah/Documents/GitHub/neighbourlyy/neighborlyy/web/Resident/attachment";

            try (InputStream input = filePart.getInputStream()) {
                Path filePath = Paths.get(uploadDirectory, fileName);
                Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
            } 
            
            int statusid = 50001;
                  
            ComplaintBean cp = new ComplaintBean ();
            cp.setComplaintType(complaintType);
            cp.setDateComplaint(sqlDate);
            cp.setAttachment(fileName);
            cp.setDescription(description);
            cp.setLocation(location);
            cp.setUserid(userid);
            cp.setStatusid(statusid);
           
            
             try (Connection conn = DBConnection.createConnection()) {
                String query = "INSERT INTO Complaint (USERID, STATUSID, COMPLAINT_TYPE_ID, COMPLAINT_DESCRIPTION, COMPLAINT_DATE, COMPLAINT_LOCATION, COMPLAINT_ATTACHMENT) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, cp.getUserid());
                stmt.setInt(2, cp.getStatusid());
                stmt.setInt(3, cp.getComplaintType());
                stmt.setString(4, cp.getDescription());
                stmt.setDate (5, cp.getDateComplaint());
                stmt.setString(6, cp.getLocation ());
                stmt.setString(7, cp.getAttachment());
                stmt.executeUpdate();
            }
                
           response.sendRedirect("/neighborlyy/Resident/complaint.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid user ID format");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) { // Catch any Exception that may occur
            if (e instanceof ClassNotFoundException) {
                // Handle ClassNotFoundException specifically
                System.out.println("Oracle JDBC Driver not found.");
            } else if (e instanceof SQLException) {
                // Handle SQLException specifically
                System.out.println("A database error occurred: " + e.getMessage());
            } else {
                // Handle other exceptions
                System.out.println("An unexpected error occurred: " + e.getMessage());
            }

            e.printStackTrace(); // Print the stack trace for debugging
            request.setAttribute("message", "An error occurred while processing your request");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
     }
        
    private void deleteComplaints (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String complaintidStr = request.getParameter("id");

        if (complaintidStr == null || complaintidStr.trim().isEmpty()) {
            request.setAttribute("message", "Invalid complaint ID");
            request.setAttribute("errorType", "deleteComplaint");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintidStr);

            // Use the helper method to get a connection
            try (Connection conn = DBConnection.createConnection()) {
                String query = "DELETE FROM Complaint WHERE COMPLAINTID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, complaintId);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("./Resident/complaint.jsp");
                } else {
                    request.setAttribute("message", "Complaint not found");
                    request.setAttribute("errorType", "deleteComplaint");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid complaint ID format");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while deleting the complaint");
            request.setAttribute("errorType", "deleteComplaint");
            request.getRequestDispatcher("error.jsp").forward(request, response);
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