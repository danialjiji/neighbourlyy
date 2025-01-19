/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import util.DBConnection; // Import your DBConnection class

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
            addComplaints(request, response);
        } else {
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

    private void addComplaints(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String complaintTypeStr = request.getParameter("complaintType");
        String description = request.getParameter("description");
        String date = request.getParameter("dateComplaint");
        String location = request.getParameter("location");
        String useridStr = request.getParameter("userid");

        if (complaintTypeStr == null || complaintTypeStr.trim().isEmpty() ||
                description == null || description.trim().isEmpty() ||
                date == null || date.trim().isEmpty() ||
                location == null || location.trim().isEmpty()) {
            request.setAttribute("message", "Please insert all values");
            request.setAttribute("errorType", "add");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

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

            int statusid = 1;
            int complainttypeid = 60001;

            try (Connection conn = DBConnection.createConnection()) { 
                String query = "INSERT INTO Complaint (USERID, STATUSID, COMPLAINT_TYPE_ID, COMPLAINT_DESCRIPTION, COMPLAINT_DATE, COMPLAINT_LOCATION, COMPLAINT_ATTACHMENT) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, userid);
                stmt.setInt(2, statusid);
                stmt.setInt(3, complainttypeid);
                stmt.setString(4, description);
                stmt.setDate(5, sqlDate);
                stmt.setString(6, location);
                stmt.setString(7, fileName);
                stmt.executeUpdate();
            }

            request.setAttribute("message", "Data successfully submitted");
           
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid user ID format");
            //request.getRequestDispatcher("error.jsp").forward(request, response);
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
            //request.getRequestDispatcher("error.jsp").forward(request, response);
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
