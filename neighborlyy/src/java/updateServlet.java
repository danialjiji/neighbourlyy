/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import util.DBConnection;

/**
 *
 * @author junmee
 */
@MultipartConfig
@WebServlet(urlPatterns = {"/updateServlet"})
public class updateServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String accessType = request.getParameter("accessType");

        if ("updateProfile".equalsIgnoreCase(accessType)) {
            updateProfile(request, response);
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
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
       
        String email = request.getParameter("email");
        String phoneNum = request.getParameter("phoneNum");
        String userIdStr = request.getParameter("userid");
        
        
    if (userIdStr == null || userIdStr.trim().isEmpty()) {
        request.setAttribute("message", "User ID is missing or invalid.");
        request.getRequestDispatcher("error.jsp").forward(request, response);
        return;
    }

        try {
            int userId = Integer.parseInt(userIdStr);
            // Use the helper method to get a connection
            try (Connection conn = DBConnection.createConnection()) {
                String query = "UPDATE users SET email = ?, phoneNum = ? WHERE userID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, email);
                    stmt.setString(2, phoneNum);
                    stmt.setInt(3, userId);

                    int rowsUpdated = stmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        response.sendRedirect("/neighborlyy/Resident/profile.jsp");
                    } else {
                        request.setAttribute("message", "No user found with the given ID");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                    }
                }
            }
     
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid user ID format");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
             if (e instanceof SQLException) {
                System.out.println("A database error occurred: " + e.getMessage());
            } else {
                System.out.println("An unexpected error occurred: " + e.getMessage());
            }
            e.printStackTrace(); // Log error for debugging
            request.setAttribute("message", "An error occurred while processing your request");
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
